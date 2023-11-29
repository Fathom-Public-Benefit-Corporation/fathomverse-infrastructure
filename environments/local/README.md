### Generate genesis file 
From inside the `indy_node_controller` docker container:
- Navigate home and create a directory: `cd home/ && mkdir create_genesis`
- Update the container and install an editor: `apt install update && apt install nano`
- Create a python script `touch genesis_from_files.py` 
- Copy the contents from the [steward-tools file](https://github.com/sovrin-foundation/steward-tools/blob/master/create_genesis/genesis_from_files.py) 
```python
#!/usr/bin/python3

import argparse
import os

from indy_common.txn_util import getTxnOrderedFields

from ledger.genesis_txn.genesis_txn_file_util import create_genesis_txn_init_ledger
from plenum.common.member.member import Member
from plenum.common.member.steward import Steward

from plenum.common.constants import TARGET_NYM, TXN_TYPE, DATA, ALIAS, BLS_KEY, \
    TXN_ID, NODE, CLIENT_IP, CLIENT_PORT, NODE_IP, NODE_PORT, CLIENT_STACK_SUFFIX, NYM, \
    STEWARD, ROLE, SERVICES, VALIDATOR, TRUSTEE, IDENTIFIER, VERKEY

import sys
import csv


def parse_trustees(trusteeFile):
   trustees = []
   with open(trusteeFile, newline='') as csvfile:
      reader = csv.DictReader(csvfile, delimiter=',')
      for row in reader:
         trustees.append({'name':row['Trustee name'], 'nym':row['Trustee DID'], 'verkey':row['Trustee verkey']})
   return trustees
         

def parse_stewards(stewardFile, trusteeDID):
   stewards = []
   nodes = []
   with open(stewardFile, newline='') as csvfile:
      reader = csv.DictReader(csvfile, delimiter=',')
      for row in reader:
         stewards.append({'nym':row['Steward DID'], 'verkey':row['Steward verkey'], 'auth_did':trusteeDID})
         nodes.append({'auth_did':row['Steward DID'], 'alias':row['Validator alias'], 'node_address':row['Node IP address'], 
                       'node_port':row['Node port'], 'client_address':row['Client IP address'], 
                       'client_port':row['Client port'], 'verkey':row['Validator verkey'], 
                       'bls_key':row['Validator BLS key'], 'bls_pop':row['Validator BLS POP']})
   return stewards, nodes


def open_ledger(pathname):
   baseDir = os.path.dirname(pathname)
   if baseDir == '':
      baseDir = './'
   else:
      baseDir = baseDir + '/'
   txnFile = os.path.basename(pathname)
   ledger = create_genesis_txn_init_ledger(baseDir, txnFile)
   ledger.reset()
   return ledger


def make_pool_genesis(pool_pathname, node_defs):
   pool_ledger = open_ledger(pool_pathname)   

   seq_no = 1
   for node_def in node_defs:
      txn = Steward.node_txn(node_def['auth_did'], node_def['alias'], node_def['verkey'],
                                  node_def['node_address'], node_def['node_port'], node_def['client_port'], 
                                  client_ip=node_def['client_address'], blskey=node_def['bls_key'],
                                  seq_no=seq_no, protocol_version=None, bls_key_proof=node_def['bls_pop'])
      pool_ledger.add(txn)
      seq_no += 1

   pool_ledger.stop()


def make_domain_genesis(domain_pathname, trustee_defs, steward_defs):
   domain_ledger = open_ledger(domain_pathname)
   
   seq_no = 1
   for trustee_def in trustee_defs:
      txn = Member.nym_txn(trustee_def['nym'], name=trustee_def['name'], verkey=trustee_def['verkey'], role=TRUSTEE,
                           seq_no=seq_no,
                           protocol_version=None)
      domain_ledger.add(txn)
      seq_no += 1   

   for steward_def in steward_defs:
      txn = Member.nym_txn(steward_def['nym'], verkey=steward_def['verkey'], role=STEWARD, 
                           creator=trustee_def['nym'],
                           seq_no=seq_no,
                           protocol_version=None)
      domain_ledger.add(txn)
      seq_no += 1
   
   domain_ledger.stop()


# --- MAIN ---

parser = argparse.ArgumentParser(description = 'Uses .csv files as inputs for trustee and steward info, and produces genesis files.')
parser.add_argument('--pool', help='[OUTPUT] pool transactions pathname.', default='./pool_transactions')
parser.add_argument('--domain', help='[OUTPUT] domain transactions pathname.', default='./domain_transactions')
required = parser.add_argument_group('required arguements')
required.add_argument('--trustees', help="[INPUT] .csv with headers: 'Trustee name', 'Trustee DID', 'Trustee verkey'", required=True)
required.add_argument('--stewards', help="[INPUT] .csv with headers: 'Steward DID', 'Steward verkey', 'Validator alias', 'Node IP address','Node port', 'Client IP address', 'Client port', 'Validator verkey', 'Validator BLS key', 'Validator BLS POP'", required=True)

args = parser.parse_args()

trustee_defs = parse_trustees(args.trustees)
steward_defs, node_defs = parse_stewards(args.stewards, trustee_defs[0]["nym"])   # The first trustee 'onboards' all stewards

make_pool_genesis(args.pool, node_defs)
make_domain_genesis(args.domain, trustee_defs, steward_defs)
```
- Paste contents into the created python script `nano genesis_from_files.py` and save the file.
- Also copy and paste the contents of both CSV files into new .csv files in the container at the same path of the script.
- Run the script `python3 ./generate_from_files.py --trustees Trustees.csv --stewards Nodes.csv`.
- Copy both contents of `domain_transactions_genesis` and `pool_transactions_genesis` into their own files within the `modules/indy/libindy/fathomverse/` folder.
- Apply changes to the infrastructure with `terraform apply`.  

### Add an acceptance mechanism

To write to an Indy Node Ledger, you’ll need to sign the [Transaction Author Aggreement (TAA)](https://github.com/hyperledger/indy-sdk/blob/main/docs/how-tos/transaction-author-agreement.md). This agreement is incorporated into the process of connecting to the node pool and requires an acceptance mechanism. For the indy-cli, the default mechanism is “For Session” and the following instructions are required to be able to use “For Session” for your indy-cli:

```
user@localhost:~$ indy-cli --config <path_to_cfg>/cliconfig.json
```

Once TAA has been configured, one can begin to create a wallet with a steward or trustee did, use the did, and create a pool, and connect to the created pool.

Schemas may then be created, for example:
```console
pool(sandbox):JOHN:did(Th7...81Y):indy> ledger schema name=Achievement version=1.0 attr_names=id,type,alignment,achievementType,creator,creditsAvailable,criteria,description,endorsement,endorsementJwt,fieldOfStudy,humanCode,image,@language,name,otherIdentifier,related,resultDescription,specialization,tag,version
Schema request has been sent to Ledger.
Metadata:
+------------------------+-----------------+---------------------+---------------------+
| From                   | Sequence Number | Request ID          | Transaction time    |
+------------------------+-----------------+---------------------+---------------------+
| Th7MpTaRZVRYnPiabds81Y | 9               | 1701144269424701937 | 2023-11-28 04:04:29 |
+------------------------+-----------------+---------------------+---------------------+
Data:
+-------------+---------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Name        | Version | Attributes                                                                                                                                                                                                                                                            |
+-------------+---------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Achievement | 1.0     | "resultDescription","endorsement","fieldOfStudy","id","creator","@language","name","creditsAvailable","humanCode","otherIdentifier","description","type","related","achievementType","endorsementJwt","specialization","criteria","version","tag","image","alignment" |
+-------------+---------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

### Building a transaction
```terminal
pool(fathomverse):JOHN:did(V4S...e6f):indy> ledger nym did=V4SGRU86Z58d6TV7PBUe6f verkey=~CoRER63DVYnWZtK8uAzNbx role=TRUSTEE send=false

Transaction has been created:
     {"identifier":"V4SGRU86Z58d6TV7PBUe6f","operation":{"dest":"V4SGRU86Z58d6TV7PBUe6f","role":"0","type":"1","verkey":"~CoRER63DVYnWZtK8uAzNbx"},"protocolVersion":2,"reqId":1700440097985973563,"signature":"4NRq1AvXi7pLtVEhhzfFLwyXJoewXnNX5RhRJK4XxP8fYaZf7o36MLhktvAwTV1NB4W6dZrb1GiEJhfaL5cXS4Lb"}
```
Multi-signing a transaction (i.e., copy and paste "Building a transaction" result into `txn` field)
```terminal
pool(fathomverse):JOHN:did(V4S...e6f):indy> ledger sign-multi txn={"identifier":"V4SGRU86Z58d6TV7PBUe6f","operation":{"dest":"V4SGRU86Z58d6TV7PBUe6f","role":"0","type":"1","verkey":"~CoRER63DVYnWZtK8uAzNbx"},"protocolVersion":2,"reqId":1700440097985973563,"signature":"4NRq1AvXi7pLtVEhhzfFLwyXJoewXnNX5RhRJK4XxP8fYaZf7o36MLhktvAwTV1NB4W6dZrb1GiEJhfaL5cXS4Lb"}

Transaction has been signed:
{"identifier":"V4SGRU86Z58d6TV7PBUe6f","operation":{"dest":"V4SGRU86Z58d6TV7PBUe6f","role":"0","type":"1","verkey":"~CoRER63DVYnWZtK8uAzNbx"},"protocolVersion":2,"reqId":1700440097985973563,"signatures":{"V4SGRU86Z58d6TV7PBUe6f":"4NRq1AvXi7pLtVEhhzfFLwyXJoewXnNX5RhRJK4XxP8fYaZf7o36MLhktvAwTV1NB4W6dZrb1GiEJhfaL5cXS4Lb"}}
```