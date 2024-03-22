
## SocialCDN

- 使用pintreest数据集
- wanted data
### Testbed

基于cloudlab和docker container的testbed

```text
	                    node-0
			              |
			node-1 _______|_______ node-2
				|                    |
			____|____            ____|____
		   |         |          |         |
        node-3     node-4     node-5    node-6

```





### DataSet
allocation_table: 用于将每个用户分配到不同的testbed上的节点

| user_id | location | action_filename |
| ------- | -------- | --------------- |
| 1992    | US       | 1992_action.dat |
| 1003    | CN       | 1003_action.dat |

action_filename: 

| usr_id | timestamp      | action_type | url                       |
| ------ | -------------- | ----------- | ------------------------- |
| 1992   | unix_timestamp | POST        | ftp://userid/filename.dat |
| 1000   |                | GET         |                           |
