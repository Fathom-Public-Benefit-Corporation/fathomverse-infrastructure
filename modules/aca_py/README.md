# Admin API

This is how to demonstrate the admin api endpoints between the two agents in the sandbox environment.

## Connect Agent-1 and Agent-2

Step 1. Create an invitation on Agent-1

```t
curl -X 'POST' \
  'http://localhost:8031/connections/create-invitation?alias=Agent-1&auto_accept=true&public=true' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{}'
```

Example output:

```json
{
  "connection_id": "3d78a198-b879-4e86-904f-aee00592784e",
  "invitation": {
    "@type": "https://didcomm.org/connections/1.0/invitation",
    "@id": "437af9c6-521e-4052-b2c2-7733398b22b6",
    "label": "Agent-1",
    "did": "did:sov:NKGKtcNwssToP5f7uhsEs4"
  },
  "invitation_url": "http://10.133.133.12:8030?c_i=eyJAdHlwZSI6ICJodHRwczovL2RpZGNvbW0ub3JnL2Nvbm5lY3Rpb25zLzEuMC9pbnZpdGF0aW9uIiwgIkBpZCI6ICI0MzdhZjljNi01MjFlLTQwNTItYjJjMi03NzMzMzk4YjIyYjYiLCAibGFiZWwiOiAiQWdlbnQtMSIsICJkaWQiOiAiZGlkOnNvdjpOS0dLdGNOd3NzVG9QNWY3dWhzRXM0In0=",
  "alias": "Agent-1"
}
```

Copy the JSON context after `"invitation":`

```json
{
    "@type": "https://didcomm.org/connections/1.0/invitation",
    "@id": "437af9c6-521e-4052-b2c2-7733398b22b6",
    "label": "Agent-1",
    "did": "did:sov:NKGKtcNwssToP5f7uhsEs4"
  }
```

Step 2. Receive the invitation on Agent-2 using the copied JSON context

```t
curl -X 'POST' \
  'http://localhost:8033/connections/receive-invitation?alias=Agent-1' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
    "@type": "https://didcomm.org/connections/1.0/invitation",
    "@id": "a8ae57b7-e1cc-4852-a6a4-4098f5e33df7",
    "label": "Agent-1",
    "did": "did:sov:NKGKtcNwssToP5f7uhsEs4"
  }'
```

Example output:

```json
{
  "state": "invitation",
  "created_at": "2023-12-03T17:18:55.865495Z",
  "updated_at": "2023-12-03T17:18:55.865495Z",
  "connection_id": "47eb995f-52e4-4b7f-bd4d-4b60587b6781",
  "their_label": "Agent-1",
  "their_role": "inviter",
  "connection_protocol": "connections/1.0",
  "rfc23_state": "invitation-received",
  "invitation_msg_id": "a8ae57b7-e1cc-4852-a6a4-4098f5e33df7",
  "accept": "manual",
  "invitation_mode": "once",
  "alias": "Agent-1"
}
```

Copy the `connection_id":` string value.

```
47eb995f-52e4-4b7f-bd4d-4b60587b6781
```

Step 3. Accept invitation on Agent-2 using the copied string.

```t
curl -X 'POST' \
  'http://localhost:8033/connections/47eb995f-52e4-4b7f-bd4d-4b60587b6781/accept-invitation' \
  -H 'accept: application/json' \
  -d ''
```

Example Output:

```json
{
  "state": "request",
  "created_at": "2023-12-03T17:18:55.865495Z",
  "updated_at": "2023-12-03T17:23:16.264174Z",
  "connection_id": "47eb995f-52e4-4b7f-bd4d-4b60587b6781",
  "my_did": "2UsbJy67t2b1UyNmTpq2gd",
  "their_label": "Agent-1",
  "their_role": "inviter",
  "connection_protocol": "connections/1.0",
  "rfc23_state": "request-sent",
  "invitation_msg_id": "a8ae57b7-e1cc-4852-a6a4-4098f5e33df7",
  "request_id": "518f769e-5cad-47f4-9f5a-77514df583d8",
  "accept": "manual",
  "invitation_mode": "once",
  "alias": "Agent-1"
}
```

Step 4. Get connections on Agent-1

```t
curl -X 'GET' \
  'http://localhost:8031/connections?alias=Agent-1' \
  -H 'accept: application/json'
```

Copy the `"connection_id":` from the JSON result containing the `"state": "request"` value.

Step 5. Accept the request on Agent-1 using the copied `"connection_id":` string value.

```t
curl -X 'POST' \
  'http://localhost:8031/connections/761cad63-6d2a-4f92-ad27-30e4a43c3fad/accept-request' \
  -H 'accept: application/json' \
  -d ''
```

Example output:

```json
{
  "state": "response",
  "created_at": "2023-12-03T17:10:34.466722Z",
  "updated_at": "2023-12-03T17:26:50.237748Z",
  "connection_id": "761cad63-6d2a-4f92-ad27-30e4a43c3fad",
  "my_did": "VWDe8tDUP54q3oD7VkrpU7",
  "their_did": "2UsbJy67t2b1UyNmTpq2gd",
  "their_label": "Agent-2",
  "their_role": "inviter",
  "connection_protocol": "connections/1.0",
  "rfc23_state": "response-received",
  "invitation_key": "CcokUqV7WkojBLxYm7gxRzsWk3q4SE8eVMmEXoYjyvKw",
  "invitation_msg_id": "a8ae57b7-e1cc-4852-a6a4-4098f5e33df7",
  "accept": "manual",
  "invitation_mode": "once",
  "alias": "Agent-1"
}
```

Step 6. Get active connections on Agent-1

```t
curl -X 'GET' \
  'http://localhost:8031/connections?alias=Agent-1&state=active' \
  -H 'accept: application/json'
```

Example Output:

```json
{
  "results": [
    {
      "state": "active",
      "created_at": "2023-12-03T17:10:34.466722Z",
      "updated_at": "2023-12-03T17:26:50.343263Z",
      "connection_id": "761cad63-6d2a-4f92-ad27-30e4a43c3fad",
      "my_did": "VWDe8tDUP54q3oD7VkrpU7",
      "their_did": "2UsbJy67t2b1UyNmTpq2gd",
      "their_label": "Agent-2",
      "their_role": "inviter",
      "connection_protocol": "connections/1.0",
      "rfc23_state": "completed",
      "invitation_key": "CcokUqV7WkojBLxYm7gxRzsWk3q4SE8eVMmEXoYjyvKw",
      "invitation_msg_id": "a8ae57b7-e1cc-4852-a6a4-4098f5e33df7",
      "accept": "manual",
      "invitation_mode": "once",
      "alias": "Agent-1"
    }
  ]
}
```

## Create a Schema on Agent-1

Prerequisites:

- An active endorser connection with an agent.

Step 1. Create schema

```t
curl -X 'POST' \
  'http://localhost:8031/schemas' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "attributes": [
    "@id",
    "@type",
    "graph"
],
  "schema_name": "ctdlasn",
  "schema_version": "1.0"
}'
```

Example output:

```json
{
  "sent": {
    "schema_id": "JJ5mHotESZ9a2W88tLB3FE:2:CompetencyFramework:1.0",
    "schema": {
      "ver": "1.0",
      "id": "JJ5mHotESZ9a2W88tLB3FE:2:CompetencyFramework:1.0",
      "name": "CompetencyFramework",
      "version": "1.0",
      "attrNames": [
        "ceasn:publisher",
        "ceasn:inLanguage",
        "ceasn:source",
        "ceasn:description",
        "ceasn:license",
        "ceasn:dateModified",
        "ceasn:name",
        "ceasn:publicationStatusType",
        "@id",
        "ceasn:comment",
        "ceasn:competencyLabel",
        "ceasn:hasChild",
        "ceasn:codedNotation",
        "ceasn:publisherName",
        "ceasn:isChildOf",
        "ceasn:competencyCategory",
        "ceasn:dateCreated",
        "ceasn:isPartOf",
        "@type",
        "ceterms:ctid",
        "ceasn:hasTopChild",
        "ceasn:competencyText",
        "ceasn:isTopChildOf"
      ],
      "seqNo": 13
    }
  },
  "schema_id": "JJ5mHotESZ9a2W88tLB3FE:2:CompetencyFramework:1.0",
  "schema": {
    "ver": "1.0",
    "id": "JJ5mHotESZ9a2W88tLB3FE:2:CompetencyFramework:1.0",
    "name": "CompetencyFramework",
    "version": "1.0",
    "attrNames": [
      "ceasn:publisher",
      "ceasn:inLanguage",
      "ceasn:source",
      "ceasn:description",
      "ceasn:license",
      "ceasn:dateModified",
      "ceasn:name",
      "ceasn:publicationStatusType",
      "@id",
      "ceasn:comment",
      "ceasn:competencyLabel",
      "ceasn:hasChild",
      "ceasn:codedNotation",
      "ceasn:publisherName",
      "ceasn:isChildOf",
      "ceasn:competencyCategory",
      "ceasn:dateCreated",
      "ceasn:isPartOf",
      "@type",
      "ceterms:ctid",
      "ceasn:hasTopChild",
      "ceasn:competencyText",
      "ceasn:isTopChildOf"
    ],
    "seqNo": 13
  }
}
```

Step 2. Create a Credential definition on Agent-1

```t
curl -X 'POST' \
  'http://localhost:8031/credential-definitions' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
      "schema_id": "Th7MpTaRZVRYnPiabds81Y:2:ctdlasn:1.0",
      "tag": "tag1",
      "support_revocation": true
    }'
```

Example Output:

```json
{
  "sent": {
    "credential_definition_id": "Th7MpTaRZVRYnPiabds81Y:3:CL:19:tag1"
  },
  "credential_definition_id": "Th7MpTaRZVRYnPiabds81Y:3:CL:19:tag1"
}
```

Step 3. Send holder (Agent-2) a credential credential offer

```t
curl -X 'POST' \
  'https://dggqvdjc-8031.use.devtunnels.ms/issue-credential-2.0/send' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "auto_remove": true,
  "comment": "ONET Competency for Blockchain Engineering",
  "connection_id": "307a7b72-d556-49ab-afeb-db1fd9509b13",
  "credential_preview": {
    "@type": "issue-credential/2.0/credential-preview",
    "attributes": [
      {
        "mime-type": "image/jpeg",
        "name": "@type",
        "value": "https://www.onetcenter.org/ctdlasn/resources/ce-0d4e47c1-05c4-11eb-870b-782bcb5df6ac"
      },
      {
        "name": "@id",
        "value": "ce-0d4e47c1-05c4-11eb-870b-782bcb5df6ac"
      },
      {
        "name": "graph",
        "value": "https://www.onetcenter.org/ctdlasn/resources/ce-8a445cba-1b1a-11ea-8239-782bcb5df6ac"
      }
    ]
  },
  "filter": {
    "indy": {
      "cred_def_id": "Th7MpTaRZVRYnPiabds81Y:3:CL:19:tag1",
      "issuer_did": "Th7MpTaRZVRYnPiabds81Y",
      "schema_id": "Th7MpTaRZVRYnPiabds81Y:2:ctdlasn:1.0",
      "schema_issuer_did": "Th7MpTaRZVRYnPiabds81Y",
      "schema_name": "ctdlasn",
      "schema_version": "1.0"
    }
  },
  "trace": false
}'
```

Example Output:

```json
{
  "state": "offer-sent",
  "created_at": "2023-12-07T16:47:50.885464Z",
  "updated_at": "2023-12-07T16:47:50.885464Z",
  "trace": false,
  "cred_ex_id": "b379bf7b-706e-4c76-bc47-0d816baef152",
  "connection_id": "307a7b72-d556-49ab-afeb-db1fd9509b13",
  "thread_id": "89a70831-4599-4c85-9fee-dbba47ec502d",
  "initiator": "self",
  "role": "issuer",
  "cred_preview": {
    "@type": "https://didcomm.org/issue-credential/2.0/credential-preview",
    "attributes": [
      {
        "name": "@type",
        "mime-type": "image/jpeg",
        "value": "https://www.onetcenter.org/ctdlasn/resources/ce-0d4e47c1-05c4-11eb-870b-782bcb5df6ac"
      },
      {
        "name": "@id",
        "value": "ce-0d4e47c1-05c4-11eb-870b-782bcb5df6ac"
      },
      {
        "name": "graph",
        "value": "https://www.onetcenter.org/ctdlasn/resources/ce-8a445cba-1b1a-11ea-8239-782bcb5df6ac"
      }
    ]
  },
  "cred_proposal": {
    "@type": "https://didcomm.org/issue-credential/2.0/propose-credential",
    "@id": "fc59f593-09d1-4822-afd8-4c39c46c5816",
    "comment": "ONET Competency for Blockchain Engineering",
    "credential_preview": {
      "@type": "https://didcomm.org/issue-credential/2.0/credential-preview",
      "attributes": [
        {
          "name": "@type",
          "mime-type": "image/jpeg",
          "value": "https://www.onetcenter.org/ctdlasn/resources/ce-0d4e47c1-05c4-11eb-870b-782bcb5df6ac"
        },
        {
          "name": "@id",
          "value": "ce-0d4e47c1-05c4-11eb-870b-782bcb5df6ac"
        },
        {
          "name": "graph",
          "value": "https://www.onetcenter.org/ctdlasn/resources/ce-8a445cba-1b1a-11ea-8239-782bcb5df6ac"
        }
      ]
    },
    "formats": [
      {
        "attach_id": "indy",
        "format": "hlindy/cred-filter@v2.0"
      }
    ],
    "filters~attach": [
      {
        "@id": "indy",
        "mime-type": "application/json",
        "data": {
          "base64": "eyJjcmVkX2RlZl9pZCI6ICJUaDdNcFRhUlpWUlluUGlhYmRzODFZOjM6Q0w6MTk6dGFnMSIsICJpc3N1ZXJfZGlkIjogIlRoN01wVGFSWlZSWW5QaWFiZHM4MVkiLCAic2NoZW1hX2lkIjogIlRoN01wVGFSWlZSWW5QaWFiZHM4MVk6MjpjdGRsYXNuOjEuMCIsICJzY2hlbWFfaXNzdWVyX2RpZCI6ICJUaDdNcFRhUlpWUlluUGlhYmRzODFZIiwgInNjaGVtYV9uYW1lIjogImN0ZGxhc24iLCAic2NoZW1hX3ZlcnNpb24iOiAiMS4wIn0="
        }
      }
    ]
  },
  "cred_offer": {
    "@type": "https://didcomm.org/issue-credential/2.0/offer-credential",
    "@id": "89a70831-4599-4c85-9fee-dbba47ec502d",
    "~thread": {},
    "comment": "create automated v2.0 credential exchange record",
    "credential_preview": {
      "@type": "https://didcomm.org/issue-credential/2.0/credential-preview",
      "attributes": [
        {
          "name": "@type",
          "mime-type": "image/jpeg",
          "value": "https://www.onetcenter.org/ctdlasn/resources/ce-0d4e47c1-05c4-11eb-870b-782bcb5df6ac"
        },
        {
          "name": "@id",
          "value": "ce-0d4e47c1-05c4-11eb-870b-782bcb5df6ac"
        },
        {
          "name": "graph",
          "value": "https://www.onetcenter.org/ctdlasn/resources/ce-8a445cba-1b1a-11ea-8239-782bcb5df6ac"
        }
      ]
    },
    "formats": [
      {
        "attach_id": "indy",
        "format": "hlindy/cred-abstract@v2.0"
      }
    ],
    "offers~attach": [
      {
        "@id": "indy",
        "mime-type": "application/json",
        "data": {
          "base64": "eyJzY2hlbWFfaWQiOiAiVGg3TXBUYVJaVlJZblBpYWJkczgxWToyOmN0ZGxhc246MS4wIiwgImNyZWRfZGVmX2lkIjogIlRoN01wVGFSWlZSWW5QaWFiZHM4MVk6MzpDTDoxOTp0YWcxIiwgImtleV9jb3JyZWN0bmVzc19wcm9vZiI6IHsiYyI6ICI5NzQ5NDM1NTA0NzQxMzAyMzk0OTU0MDM4NjIzODk0OTc3Njc3MzYwOTUzNjEwNzU0NjI2ODYyNDUwMjY0MjE4OTI2NTI0ODQ1ODMwNCIsICJ4el9jYXAiOiAiMjMyODM3OTU3NDgwMDA4NTUyNTg2ODgyNDAxOTk5NzE5MTM3MDc3NjU2NTYxOTIzODE5NDMxMDg5NjM1MjUzODI5OTY1ODUwNzQxNzc2NDQ1MTIxNDUyNzY4MjQ2MjEyNTQwNDQyMjM1OTc5ODgzNzM4NzUzMzkzNDcyOTkyMDU2NjIwMjE1ODgzNjU0Mjc5ODQ1MDI2OTM0MjQ5NTc1OTAxODkxMzkxMzgxMDUwMTI1MTY4NjU4OTUzNTgyMjM0MjE0MTk5MDY2NDkwMDUxMTcwODk0ODE5OTU5ODg5MTM4ODk3NDkwOTkyNzUwMDYyMjY4NjU5NTk1OTA2ODI3MjY0MDYwMTAzNzIwNTAyNjE5Njk0MDYxMjgwNDg2NzA1OTUzNDEyNjk1NTk2NzQ3Mjg1ODkzNzQ5ODM5OTAzMjI3MDkzNTY1NzI3NjI3MjI1MTU2MDQ0Njg4NzEyNTI4MDY2NTczMTEzMjE3NjkyNjM0NTY3NTE3ODM2OTQzNzMzOTU4NzAzNTY3MjQ0MTIyODMwNTg2MTEzMjgzODI5MDQwMDIxMjU4MTU4MTUzNzI5NzAyMDY3MzI0NjY5Mzk2MDQ0MjY1MjU2ODUwMDcwOTU2MjQ3Nzg4NTE5NjIyNDY3NjEzMzE4MDgwMjEyNzQ3ODcyNjMzNDIwMzE4NjE0MDYxMzMwNjk2ODMwMDUwODQwNDU1ODQ1Mjc2MjMxOTY2NDUzNjg4MzU4MDE2MzA5NDYwODc5NzExNzE1ODAxMzQ4Njk3ODIyNzA3MTMxODU0NjY4MTkwNTA5NzM3OTUxNDA4NTcwNjMxNDIyNjkzMDQ3OTMxMjIzNzI0OTUyNDI2NjA5NDgzNjQxMzIxOTY5MzYxOTAxOTg4MjExNjI0NjMzMzU0NDg4MDIwMDcwNzgwMzg2ODM5NiIsICJ4cl9jYXAiOiBbWyJncmFwaCIsICIxNjkwOTc0Mzc3NzYyNjAxNDMzNzI2NTgyNDA0MzA0NDE5MDYwOTc5OTI3MzYxNzA3MjkyNjI1NjgwNzAzMzE1MDAwMzU3Nzk0MjM3NzY2NzI3NTk0MDI3NTM4MjMzNzQwMzMyNTczMTIzNTczNjAwMjA1NDgxOTcwNTQ4NTYwOTY2NDQyNTE2MTQ1MzI2NTQzNjE3NTQxOTQ5ODE5ODEzOTY2OTUzOTY4OTQyNzAwMjk0MzY4NDEyNTYxMjY0ODI1Njc3OTc3NjU2NjI4NDY1ODk1MTE2NzY0MDkxMjMyMjQwNTE2MjUxMjI2MzA0Nzk3OTA5ODQ2MTUwODAyMjI0MDM5MjY3NzU3NDk5MDUyODc5NTA3NjQ3MTg3MDU4MTEyMTQyNDg0ODYwODQ1Nzc0MjU3NzAyMTY3ODkwMzk5ODE0MTYzNzkwOTU5NTgxNzk4MDQ4MTg0NzE0NDkxNTM0MDk3MzQxNDQyMDY3Mzg3ODAwODAwNTM3ODU0ODQ4MjUxODM2OTMwMzU1NjE4NTk4ODU1ODUwOTA3NjI0NDkzNjgxNzI3MTg2MzgwNDUyNDQxMTEzOTQ0MzMwMTQyMDExNDE0NzgzNDYyMjI5NjQ5OTU1ODE4NTc2MjI1Mjk0NDgzMDQ3ODg0MTgwOTA0NDk5MjA3NTcwMjU4MjYxMTE1NTA5NDYwNDgzMjU1MTk1ODUxNzM1MDA5NTgwMTk1NDAwNjg2NDkxNTkyNzgzNDUxODIyMTc4NjAwNjc5MzU0NjI1NzE0MTY2MjMyODA1NDU2MTM0MjkzMDU0NDM0NTcyODYxMDM1MTU4ODg2NTcwNTM4ODI0NjE2NTc5OTQwMTI0NTg2MzE5NDg1MDEwMjAzMTAwMTEzNzM0ODUyMzAzNTM5MzE2OTcxODI2OTI2MjM4NjIzNTQiXSwgWyJAdHlwZSIsICIyMjYzNjg4NzIxOTE4ODIzMzE4OTU5ODQ0MjAxNTg1ODY4ODgzNDY4NjQ3NDQ2Njc3NzMzNDY2OTU1NTk2MDYwNDU3MzI0NjA3MTE0MDM3MTE2MjQwNDc0NTE0OTk2NjA2MTM5MTE4MzU1MzQxMDAwOTIwNzgyMjgyNDQ5NzI3MjQ1MzA3MjY1OTUwNDEzODg0NTUzNjkxMjIyOTA4MzQ3MDA0Mjg1NTk4NzM5NzM5OTU4ODE4NTc2MTMyMDI5ODQwNjE0NzgzMjUwNDEzMzk2Nzc0ODc2MjgwMDgyMDM2NTg5NDMyMzI2MjMxMjkzMzg5NzI0ODYzMzU3NTMyOTY2MzM2NDc1NDI5MjAzNzMxMTIyMjg5NDQzNTA5MjgwNDA2MTI5NjIwMjUwOTE2ODQ0NjYxNzg5MDQ0Nzk5NjkwNjk5MDI0NjYzNTk3MDQ0MjMyNjM4NzMwNDEyNTEyMjg2MzkxNTM2NjM4MDg4OTk4ODcwNzQwMTQ5MzYyNDY0MDI3MjI5NTE5MzgzOTQ4NTk5NDY3MDYyMTk3ODQxMDE0NjA2NDAwMDcyODYwNzUwNzc2NTMwOTk1NDk0MjAzNzQwNzY5MDEwMjg3MTg5MTA5NzA2NTkxMzA5NzY1MTg3MTI1MDE3MTU0NTM4MDc2MzA2NDg2NjE5MDc0MTgwNTA0NjE3NzQwOTU2MDAwNzg4NzE3NjA5MTYxMjAwNDc2NzQ5NDA4NjM5MTgwNjI0NzE3ODAzNDU0ODM3MDc3NzAxMDI5Mzk5MzU1OTcyMjU5NzE2MjA4MzA4NDU2NzA4NTgzODYyMzEwMDI4NjYyMjU0NzkzNjQxNzk1MDYyNjE4NTQ2Njk3MTg5ODg4Mzc5NTc1Mzc1MTE3MTI2MDU0Nzk5OTY1NzcxNjAxMDA3NzQ4NjE4MzEyMzI2Il0sIFsiQGlkIiwgIjExODM3NDIzMDA4ODE3MzQ5MjY2MDA2MDU2MTgyODg3OTk4ODIzMDA4ODM1NzY3ODA0Nzc3NDEzMDI0MjM0NzY4NjE4MDMwNjAwNjUzMzUyMTM0NTAyMDAwODM3NjkxMTE4OTQ0ODQ5NzkyNDY2NDQ1NTgwMzMzNjE5MDUxNDU4MzY4Mjc3NzU0MzM0MTg0MjI4NjE4MjgwMDQxNDkxNDE5MDAzOTU0ODM2MDY5MzkwMDU5MjY1NzIzODY5NTk0NTExNjgyODQ5MTI0Nzk1NDg3NTQ5MjExMzM1OTc0MTQ2Mjk3OTE0MTkwNTE1OTAzNTU4ODg0MDAzNzA5NjAzNDE3OTc2NTY0NTM0NDQ3MTA0Mzc5MzU2OTI0NzY5OTM4NjQ3MDQwMjUzMjYyODM4NTc0NzY3NzE0ODE4NDYzMDk2OTg4MjQzMDk2NTEzOTA2OTUzODg1MjA2OTA5OTgyMTkyODg5NTk1MTMzMzg5MzUyMjQwNDE1ODEyNDI4MjA3ODYwNzY2NTIxNTI0Njk5NTA2NzA3MjE4NjkwMjM3OTQyMDc0MDAzNzIxMzQyMTIxMzYyMjE2MDIyNjQ0NjkzMzc1ODUzNjI3NTIxODQzNTQ2MTI3NjY2MTY5MTExMjIzNDE3MDc1MTE2NDgxMzI3ODE1NjE4NzY4MzEyNTg3NjUwMDE3OTg4NzM4OTUxNTA0OTUyMTM5ODQzNDM2MTA0NjUwMDIyMjUwOTkyMTYzODM0ODM2OTI1NzIzOTc0NTgwNDkxOTg1MjMwNTc1NDk2MTk5ODY2MjE0NjYyOTQ2NzU3MDYwMDA0MjIwOTYyNjkzODIwMjI3NDA1ODUxMzI2OTE0NjgxMzA3MjE3MzQwMTUyMTc5NTIyNTA3OTQ1MDcyMDI3MDY5MTgzODg0ODExMTU4NjQxOCJdLCBbIm1hc3Rlcl9zZWNyZXQiLCAiMTkyNzYxMTQ3MDU3OTUzNTc1NDUzMDIzOTQwNDM1NjE2MzUwMTYwMTMyMDI1NDA4MzYxOTYxMDk2NDU2ODkwNzM2MDY3NzIyMTMxMzQ5NDAyODE2Nzk0ODIwNTEzNTA2NDUxNjExOTMxMzQ0MzA4MjUwNzc0NjQzNTcxMzgzNTY2OTc0NDM3MjIwMjczOTkwMzk5OTU3ODY4Mjc5NjQ2NDkxOTE0ODU5NjMzNjQwNjU3MTQxMTY0NDMyNjg4MDk4ODc3NDA1NDg2NTMwMDQxNjk2MTc2NTY5NjQ2Mjg2MDg3Njc2NjIyNjgxNTM5ODUyNDA2MDE2NDI0NDM1OTE3ODg3ODMwMjQ5MTkyNzk2NjE2NTA4Njg4MTQ0NTU0MTM5MTUyMzY2MTYxNTEzMjg2NjIxNDc2MTY0NzIzMTAyMTIzMDI5MzM5MTkwMTEzNzg4Mzc5MDU4NjQyNTI4NDg3MDk4NjQ3OTA4NjkwMDg3MTUwMjAyMzQ0NTYxMDkyNjc3MDAxNTA5OTcwMDgwOTU1NTQ5MTg5NDQ0MjAyNTQ5MDQyNjc5NTEyOTQzNTcxMzg2MTY3ODc0MTYxODAwOTYxNDA0OTUxNDEwNDU4MTA4MDE2NDQxOTA2NTA4MzIzMjUwOTY0Nzg1MjMyOTc4OTcxODM0MTY1NDU5MzIzNzk5NjcyMzM2MTc3NTQ4MTI4NzIwNjAwNTQ3ODU3NzkxOTI5MDc5NTg5MjE4OTQ3NTczNTk5Nzc2MzY1MTQ3MzY2ODI4ODg2NzIyMTc2MjMyNzM4MDE3NzY1Mzg1MjkxMDEwNzIzODYxMzk0MTY2MzE1NTI4NDY1Mzk4MDEwOTEwNjQ3NjMxODkxMzAyNzA2MDc0OTM5OTkyNzI0Njg0MTIzMDM2MTQ5MjEwMzg3MDQ2OTM1MTQwMDY4MCJdXX0sICJub25jZSI6ICIzNDc0ODQ1MTQzMDg0NTQwNDA5MzYxOTkifQ=="
        }
      }
    ]
  },
  "by_format": {
    "cred_proposal": {
      "indy": {
        "cred_def_id": "Th7MpTaRZVRYnPiabds81Y:3:CL:19:tag1",
        "issuer_did": "Th7MpTaRZVRYnPiabds81Y",
        "schema_id": "Th7MpTaRZVRYnPiabds81Y:2:ctdlasn:1.0",
        "schema_issuer_did": "Th7MpTaRZVRYnPiabds81Y",
        "schema_name": "ctdlasn",
        "schema_version": "1.0"
      }
    },
    "cred_offer": {
      "indy": {
        "schema_id": "Th7MpTaRZVRYnPiabds81Y:2:ctdlasn:1.0",
        "cred_def_id": "Th7MpTaRZVRYnPiabds81Y:3:CL:19:tag1",
        "key_correctness_proof": {
          "c": "97494355047413023949540386238949776773609536107546268624502642189265248458304",
          "xz_cap": "2328379574800085525868824019997191370776565619238194310896352538299658507417764451214527682462125404422359798837387533934729920566202158836542798450269342495759018913913810501251686589535822342141990664900511708948199598891388974909927500622686595959068272640601037205026196940612804867059534126955967472858937498399032270935657276272251560446887125280665731132176926345675178369437339587035672441228305861132838290400212581581537297020673246693960442652568500709562477885196224676133180802127478726334203186140613306968300508404558452762319664536883580163094608797117158013486978227071318546681905097379514085706314226930479312237249524266094836413219693619019882116246333544880200707803868396",
          "xr_cap": [
            [
              "graph",
              "169097437776260143372658240430441906097992736170729262568070331500035779423776672759402753823374033257312357360020548197054856096644251614532654361754194981981396695396894270029436841256126482567797765662846589511676409123224051625122630479790984615080222403926775749905287950764718705811214248486084577425770216789039981416379095958179804818471449153409734144206738780080053785484825183693035561859885585090762449368172718638045244111394433014201141478346222964995581857622529448304788418090449920757025826111550946048325519585173500958019540068649159278345182217860067935462571416623280545613429305443457286103515888657053882461657994012458631948501020310011373485230353931697182692623862354"
            ],
            [
              "@type",
              "2263688721918823318959844201585868883468647446677733466955596060457324607114037116240474514996606139118355341000920782282449727245307265950413884553691222908347004285598739739958818576132029840614783250413396774876280082036589432326231293389724863357532966336475429203731122289443509280406129620250916844661789044799690699024663597044232638730412512286391536638088998870740149362464027229519383948599467062197841014606400072860750776530995494203740769010287189109706591309765187125017154538076306486619074180504617740956000788717609161200476749408639180624717803454837077701029399355972259716208308456708583862310028662254793641795062618546697189888379575375117126054799965771601007748618312326"
            ],
            [
              "@id",
              "118374230088173492660060561828879988230088357678047774130242347686180306006533521345020008376911189448497924664455803336190514583682777543341842286182800414914190039548360693900592657238695945116828491247954875492113359741462979141905159035588840037096034179765645344471043793569247699386470402532628385747677148184630969882430965139069538852069099821928895951333893522404158124282078607665215246995067072186902379420740037213421213622160226446933758536275218435461276661691112234170751164813278156187683125876500179887389515049521398434361046500222509921638348369257239745804919852305754961998662146629467570600042209626938202274058513269146813072173401521795225079450720270691838848111586418"
            ],
            [
              "master_secret",
              "1927611470579535754530239404356163501601320254083619610964568907360677221313494028167948205135064516119313443082507746435713835669744372202739903999578682796464919148596336406571411644326880988774054865300416961765696462860876766226815398524060164244359178878302491927966165086881445541391523661615132866214761647231021230293391901137883790586425284870986479086900871502023445610926770015099700809555491894442025490426795129435713861678741618009614049514104581080164419065083232509647852329789718341654593237996723361775481287206005478577919290795892189475735997763651473668288867221762327380177653852910107238613941663155284653980109106476318913027060749399927246841230361492103870469351400680"
            ]
          ]
        },
        "nonce": "347484514308454040936199"
      }
    }
  },
  "auto_offer": false,
  "auto_issue": true,
  "auto_remove": true
}
```

Check the logs of Agent-2 and view that the credential has been automatically received

```
2023-12-07 16:47:50,932 aries_cloudagent.messaging.base_handler INFO Received v2.0 credential offer message:

{
  "@type": "https://didcomm.org/issue-credential/2.0/offer-credential",
  "@id": "89a70831-4599-4c85-9fee-dbba47ec502d",
  "~thread": {},
  "comment": "create automated v2.0 credential exchange record",
  "credential_preview": {
    "@type": "https://didcomm.org/issue-credential/2.0/credential-preview",
    "attributes": [
      {
        "name": "@type",
        "mime-type": "image/jpeg",
        "value": "https://www.onetcenter.org/ctdlasn/resources/ce-0d4e47c1-05c4-11eb-870b-782bcb5df6ac"
      },
      {
        "name": "@id",
        "value": "ce-0d4e47c1-05c4-11eb-870b-782bcb5df6ac"
      },
      {
        "name": "graph",
        "value": "https://www.onetcenter.org/ctdlasn/resources/ce-8a445cba-1b1a-11ea-8239-782bcb5df6ac"
      }
    ]
  },
  "formats": [
    {
      "attach_id": "indy",
      "format": "hlindy/cred-abstract@v2.0"
    }
  ],
  "offers~attach": [
    {
      "@id": "indy",
      "mime-type": "application/json",
      "data": {
        "base64": "eyJzY2hlbWFfaWQiOiAiVGg3TXBUYVJaVlJZblBpYWJkczgxWToyOmN0ZGxhc246MS4wIiwgImNyZWRfZGVmX2lkIjogIlRoN01wVGFSWlZSWW5QaWFiZHM4MVk6MzpDTDoxOTp0YWcxIiwgImtleV9jb3JyZWN0bmVzc19wcm9vZiI6IHsiYyI6ICI5NzQ5NDM1NTA0NzQxMzAyMzk0OTU0MDM4NjIzODk0OTc3Njc3MzYwOTUzNjEwNzU0NjI2ODYyNDUwMjY0MjE4OTI2NTI0ODQ1ODMwNCIsICJ4el9jYXAiOiAiMjMyODM3OTU3NDgwMDA4NTUyNTg2ODgyNDAxOTk5NzE5MTM3MDc3NjU2NTYxOTIzODE5NDMxMDg5NjM1MjUzODI5OTY1ODUwNzQxNzc2NDQ1MTIxNDUyNzY4MjQ2MjEyNTQwNDQyMjM1OTc5ODgzNzM4NzUzMzkzNDcyOTkyMDU2NjIwMjE1ODgzNjU0Mjc5ODQ1MDI2OTM0MjQ5NTc1OTAxODkxMzkxMzgxMDUwMTI1MTY4NjU4OTUzNTgyMjM0MjE0MTk5MDY2NDkwMDUxMTcwODk0ODE5OTU5ODg5MTM4ODk3NDkwOTkyNzUwMDYyMjY4NjU5NTk1OTA2ODI3MjY0MDYwMTAzNzIwNTAyNjE5Njk0MDYxMjgwNDg2NzA1OTUzNDEyNjk1NTk2NzQ3Mjg1ODkzNzQ5ODM5OTAzMjI3MDkzNTY1NzI3NjI3MjI1MTU2MDQ0Njg4NzEyNTI4MDY2NTczMTEzMjE3NjkyNjM0NTY3NTE3ODM2OTQzNzMzOTU4NzAzNTY3MjQ0MTIyODMwNTg2MTEzMjgzODI5MDQwMDIxMjU4MTU4MTUzNzI5NzAyMDY3MzI0NjY5Mzk2MDQ0MjY1MjU2ODUwMDcwOTU2MjQ3Nzg4NTE5NjIyNDY3NjEzMzE4MDgwMjEyNzQ3ODcyNjMzNDIwMzE4NjE0MDYxMzMwNjk2ODMwMDUwODQwNDU1ODQ1Mjc2MjMxOTY2NDUzNjg4MzU4MDE2MzA5NDYwODc5NzExNzE1ODAxMzQ4Njk3ODIyNzA3MTMxODU0NjY4MTkwNTA5NzM3OTUxNDA4NTcwNjMxNDIyNjkzMDQ3OTMxMjIzNzI0OTUyNDI2NjA5NDgzNjQxMzIxOTY5MzYxOTAxOTg4MjExNjI0NjMzMzU0NDg4MDIwMDcwNzgwMzg2ODM5NiIsICJ4cl9jYXAiOiBbWyJncmFwaCIsICIxNjkwOTc0Mzc3NzYyNjAxNDMzNzI2NTgyNDA0MzA0NDE5MDYwOTc5OTI3MzYxNzA3MjkyNjI1NjgwNzAzMzE1MDAwMzU3Nzk0MjM3NzY2NzI3NTk0MDI3NTM4MjMzNzQwMzMyNTczMTIzNTczNjAwMjA1NDgxOTcwNTQ4NTYwOTY2NDQyNTE2MTQ1MzI2NTQzNjE3NTQxOTQ5ODE5ODEzOTY2OTUzOTY4OTQyNzAwMjk0MzY4NDEyNTYxMjY0ODI1Njc3OTc3NjU2NjI4NDY1ODk1MTE2NzY0MDkxMjMyMjQwNTE2MjUxMjI2MzA0Nzk3OTA5ODQ2MTUwODAyMjI0MDM5MjY3NzU3NDk5MDUyODc5NTA3NjQ3MTg3MDU4MTEyMTQyNDg0ODYwODQ1Nzc0MjU3NzAyMTY3ODkwMzk5ODE0MTYzNzkwOTU5NTgxNzk4MDQ4MTg0NzE0NDkxNTM0MDk3MzQxNDQyMDY3Mzg3ODAwODAwNTM3ODU0ODQ4MjUxODM2OTMwMzU1NjE4NTk4ODU1ODUwOTA3NjI0NDkzNjgxNzI3MTg2MzgwNDUyNDQxMTEzOTQ0MzMwMTQyMDExNDE0NzgzNDYyMjI5NjQ5OTU1ODE4NTc2MjI1Mjk0NDgzMDQ3ODg0MTgwOTA0NDk5MjA3NTcwMjU4MjYxMTE1NTA5NDYwNDgzMjU1MTk1ODUxNzM1MDA5NTgwMTk1NDAwNjg2NDkxNTkyNzgzNDUxODIyMTc4NjAwNjc5MzU0NjI1NzE0MTY2MjMyODA1NDU2MTM0MjkzMDU0NDM0NTcyODYxMDM1MTU4ODg2NTcwNTM4ODI0NjE2NTc5OTQwMTI0NTg2MzE5NDg1MDEwMjAzMTAwMTEzNzM0ODUyMzAzNTM5MzE2OTcxODI2OTI2MjM4NjIzNTQiXSwgWyJAdHlwZSIsICIyMjYzNjg4NzIxOTE4ODIzMzE4OTU5ODQ0MjAxNTg1ODY4ODgzNDY4NjQ3NDQ2Njc3NzMzNDY2OTU1NTk2MDYwNDU3MzI0NjA3MTE0MDM3MTE2MjQwNDc0NTE0OTk2NjA2MTM5MTE4MzU1MzQxMDAwOTIwNzgyMjgyNDQ5NzI3MjQ1MzA3MjY1OTUwNDEzODg0NTUzNjkxMjIyOTA4MzQ3MDA0Mjg1NTk4NzM5NzM5OTU4ODE4NTc2MTMyMDI5ODQwNjE0NzgzMjUwNDEzMzk2Nzc0ODc2MjgwMDgyMDM2NTg5NDMyMzI2MjMxMjkzMzg5NzI0ODYzMzU3NTMyOTY2MzM2NDc1NDI5MjAzNzMxMTIyMjg5NDQzNTA5MjgwNDA2MTI5NjIwMjUwOTE2ODQ0NjYxNzg5MDQ0Nzk5NjkwNjk5MDI0NjYzNTk3MDQ0MjMyNjM4NzMwNDEyNTEyMjg2MzkxNTM2NjM4MDg4OTk4ODcwNzQwMTQ5MzYyNDY0MDI3MjI5NTE5MzgzOTQ4NTk5NDY3MDYyMTk3ODQxMDE0NjA2NDAwMDcyODYwNzUwNzc2NTMwOTk1NDk0MjAzNzQwNzY5MDEwMjg3MTg5MTA5NzA2NTkxMzA5NzY1MTg3MTI1MDE3MTU0NTM4MDc2MzA2NDg2NjE5MDc0MTgwNTA0NjE3NzQwOTU2MDAwNzg4NzE3NjA5MTYxMjAwNDc2NzQ5NDA4NjM5MTgwNjI0NzE3ODAzNDU0ODM3MDc3NzAxMDI5Mzk5MzU1OTcyMjU5NzE2MjA4MzA4NDU2NzA4NTgzODYyMzEwMDI4NjYyMjU0NzkzNjQxNzk1MDYyNjE4NTQ2Njk3MTg5ODg4Mzc5NTc1Mzc1MTE3MTI2MDU0Nzk5OTY1NzcxNjAxMDA3NzQ4NjE4MzEyMzI2Il0sIFsiQGlkIiwgIjExODM3NDIzMDA4ODE3MzQ5MjY2MDA2MDU2MTgyODg3OTk4ODIzMDA4ODM1NzY3ODA0Nzc3NDEzMDI0MjM0NzY4NjE4MDMwNjAwNjUzMzUyMTM0NTAyMDAwODM3NjkxMTE4OTQ0ODQ5NzkyNDY2NDQ1NTgwMzMzNjE5MDUxNDU4MzY4Mjc3NzU0MzM0MTg0MjI4NjE4MjgwMDQxNDkxNDE5MDAzOTU0ODM2MDY5MzkwMDU5MjY1NzIzODY5NTk0NTExNjgyODQ5MTI0Nzk1NDg3NTQ5MjExMzM1OTc0MTQ2Mjk3OTE0MTkwNTE1OTAzNTU4ODg0MDAzNzA5NjAzNDE3OTc2NTY0NTM0NDQ3MTA0Mzc5MzU2OTI0NzY5OTM4NjQ3MDQwMjUzMjYyODM4NTc0NzY3NzE0ODE4NDYzMDk2OTg4MjQzMDk2NTEzOTA2OTUzODg1MjA2OTA5OTgyMTkyODg5NTk1MTMzMzg5MzUyMjQwNDE1ODEyNDI4MjA3ODYwNzY2NTIxNTI0Njk5NTA2NzA3MjE4NjkwMjM3OTQyMDc0MDAzNzIxMzQyMTIxMzYyMjE2MDIyNjQ0NjkzMzc1ODUzNjI3NTIxODQzNTQ2MTI3NjY2MTY5MTExMjIzNDE3MDc1MTE2NDgxMzI3ODE1NjE4NzY4MzEyNTg3NjUwMDE3OTg4NzM4OTUxNTA0OTUyMTM5ODQzNDM2MTA0NjUwMDIyMjUwOTkyMTYzODM0ODM2OTI1NzIzOTc0NTgwNDkxOTg1MjMwNTc1NDk2MTk5ODY2MjE0NjYyOTQ2NzU3MDYwMDA0MjIwOTYyNjkzODIwMjI3NDA1ODUxMzI2OTE0NjgxMzA3MjE3MzQwMTUyMTc5NTIyNTA3OTQ1MDcyMDI3MDY5MTgzODg0ODExMTU4NjQxOCJdLCBbIm1hc3Rlcl9zZWNyZXQiLCAiMTkyNzYxMTQ3MDU3OTUzNTc1NDUzMDIzOTQwNDM1NjE2MzUwMTYwMTMyMDI1NDA4MzYxOTYxMDk2NDU2ODkwNzM2MDY3NzIyMTMxMzQ5NDAyODE2Nzk0ODIwNTEzNTA2NDUxNjExOTMxMzQ0MzA4MjUwNzc0NjQzNTcxMzgzNTY2OTc0NDM3MjIwMjczOTkwMzk5OTU3ODY4Mjc5NjQ2NDkxOTE0ODU5NjMzNjQwNjU3MTQxMTY0NDMyNjg4MDk4ODc3NDA1NDg2NTMwMDQxNjk2MTc2NTY5NjQ2Mjg2MDg3Njc2NjIyNjgxNTM5ODUyNDA2MDE2NDI0NDM1OTE3ODg3ODMwMjQ5MTkyNzk2NjE2NTA4Njg4MTQ0NTU0MTM5MTUyMzY2MTYxNTEzMjg2NjIxNDc2MTY0NzIzMTAyMTIzMDI5MzM5MTkwMTEzNzg4Mzc5MDU4NjQyNTI4NDg3MDk4NjQ3OTA4NjkwMDg3MTUwMjAyMzQ0NTYxMDkyNjc3MDAxNTA5OTcwMDgwOTU1NTQ5MTg5NDQ0MjAyNTQ5MDQyNjc5NTEyOTQzNTcxMzg2MTY3ODc0MTYxODAwOTYxNDA0OTUxNDEwNDU4MTA4MDE2NDQxOTA2NTA4MzIzMjUwOTY0Nzg1MjMyOTc4OTcxODM0MTY1NDU5MzIzNzk5NjcyMzM2MTc3NTQ4MTI4NzIwNjAwNTQ3ODU3NzkxOTI5MDc5NTg5MjE4OTQ3NTczNTk5Nzc2MzY1MTQ3MzY2ODI4ODg2NzIyMTc2MjMyNzM4MDE3NzY1Mzg1MjkxMDEwNzIzODYxMzk0MTY2MzE1NTI4NDY1Mzk4MDEwOTEwNjQ3NjMxODkxMzAyNzA2MDc0OTM5OTkyNzI0Njg0MTIzMDM2MTQ5MjEwMzg3MDQ2OTM1MTQwMDY4MCJdXX0sICJub25jZSI6ICIzNDc0ODQ1MTQzMDg0NTQwNDA5MzYxOTkifQ=="
      }
    }
  ]
}
```

### Miscellanious

Checking "Multi-use" upon creation of an invitation from an Agent generates a url:

```t
http://10.133.133.12:8030?c_i=eyJAdHlwZSI6ICJodHRwczovL2RpZGNvbW0ub3JnL2Nvbm5lY3Rpb25zLzEuMC9pbnZpdGF0aW9uIiwgIkBpZCI6ICJhYTE2NThmYi0zZTUwLTRlOTItOTEzYS1jZGM0Nzk1ZGU5MjkiLCAibGFiZWwiOiAiQWdlbnQtMSIsICJyZWNpcGllbnRLZXlzIjogWyI2WmUxRTNFQ1N4ajMxZXpiU1l0ckJtMzlXUmdnY0JSSkV6dlg3UFhlVlB0WiJdLCAic2VydmljZUVuZHBvaW50IjogImh0dHA6Ly8xMC4xMzMuMTMzLjEyOjgwMzAifQ==
```
