Valid-Ready Handshakes:

1. valid_register.v和ready_register.v分别为实现对Valid和ready信号打拍的模块；
2. top_module.v为顶层模块，handshakes_tb.sv为Testbench；
3. normal synchronous handshake.png - 不打拍情况下，主从采用Valid-Ready同步握手的仿真信号波形；
4. valid.png - master的valid信号不满足时序要求时，用寄存器对valid信号打一拍后的仿真信号波形；
5. ready.png - slave的ready信号不满足时序要求时，用寄存器对ready信号打一拍后的仿真信号波形；
6. valid and ready.png - valid和ready信号都不满足时序要求时，用寄存器对valid和ready信号都打一拍后的仿真信号波形。
