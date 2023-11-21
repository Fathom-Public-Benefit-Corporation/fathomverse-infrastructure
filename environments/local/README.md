### Add an acceptance Mechanism

To write to an Indy Node Ledger, you’ll need to sign the [Transaction Author Aggreement (TAA)](https://github.com/hyperledger/indy-sdk/blob/main/docs/how-tos/transaction-author-agreement.md). This agreement is incorporated into the process of connecting to the node pool and requires an acceptance mechanism. For the indy-cli, the default mechanism is “For Session” and the following instructions are required to be able to use “For Session” for your indy-cli:

```
user@localhost:~$ indy-cli --config <path_to_cfg>/cliconfig.json
```

### Generate genesis file 
From inside the `indy_node_controller` docker container:
- Navigate home and create a directory: `cd home/ && mkdir create_genesis`
- Update the container and install an editor: `apt install update && apt copy and paste the python script into 
