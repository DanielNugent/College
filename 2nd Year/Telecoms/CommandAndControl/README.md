# Java socket programming application (Command and Control)
The purpose of the program is to implement a protocol that forwards messages from a Command & Control (C&C) application to a broker which in turn distributes these messages to several Workers. The six features to be implemented were
1. Workers that accept a name as input, send a message that they are volunteering for work to a broker and print work assignments that have been forwarded by a broker. 
2. C&C server that accepts a work description as input and transmits a message with the work description to a broker.  
3. A broker that receives messages from workers, maintains lists of available workers and forwards incoming work descriptions to the workers. 
4. Workers may choose to reply to the broker with results from work they carried out or withdraw their availability. 
5. Work descriptions from a C&C application may request the same work description to be sent to one, several workers or all workers. 
6. The broker and the workers may implement acknowledgements and the C&C may wait for acknowledgements from a broker before proceeding to accept input of another work description. 

