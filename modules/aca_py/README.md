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

## Create a Schema on Agent-2

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

Step 2. Create a Credential definition on Agent 1

```t
curl -X 'POST' \
  'http://localhost:8031/credential-definitions' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
      "schema_id": "JJ5mHotESZ9a2W88tLB3FE:2:CompetencyFramework:1.0",
      "tag": "tag1",
      "support_revocation": true
    }'
```
