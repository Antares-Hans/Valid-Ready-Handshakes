Valid-Ready Handshakes描述:

a) 总线master发出data信号，同时master用valid信号拉高表示data有效；
b) 总线slave发出ready信号，ready信号拉高表示slave可以接收数据；
c) 当valid和slave同时为高时，表示data信号从master到slave发送接收成功。

1. valid_register.v和ready_register.v分别为实现对Valid和ready信号打拍的模块；
2. top_module.v为顶层模块，handshakes_tb.sv为Testbench；
3. normal synchronous handshake.png - 不打拍情况下，主从采用Valid-Ready同步握手的仿真信号波形；
4. valid.png - master的valid信号不满足时序要求时，用寄存器对valid信号打一拍后的仿真信号波形；
5. ready.png - slave的ready信号不满足时序要求时，用寄存器对ready信号打一拍后的仿真信号波形；
6. valid and ready.png - valid和ready信号都不满足时序要求时，用寄存器对valid和ready信号都打一拍后的仿真信号波形。
