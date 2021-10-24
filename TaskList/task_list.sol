pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract task_list {

    struct task {
        string taskName;
        uint32 timestamp;
        bool condition;
    }

    uint8 numTask = 1;
    uint8[] numbersTasks;
    mapping (uint8 => task) tasks;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}
    
    function newTask(string tName) public checkOwnerAndAccept {
        uint8 taskID = numTask++;
        tasks[taskID] = task(tName, now, false);
        numbersTasks.push(taskID);
    }

    function countOpenTasks() public checkOwnerAndAccept returns (uint8 countOT) {
        uint8 taskLen = numTask;
        while (taskLen > 1) {
            if (tasks[taskLen].condition == false) {
                countOT++;
            }
            taskLen--;
        }
    }

    function taskCompliete(uint8 taskID) public checkOwnerAndAccept {
        tasks[taskID].condition = true;
    }

    function taskDelete(uint8 taskID) public checkOwnerAndAccept {
        delete tasks[taskID].taskName;
        delete tasks[taskID].timestamp;
        tasks[taskID].condition = true;
        delete numbersTasks[taskID - 1];
    }

    function getTask(uint8 taskID) public checkOwnerAndAccept returns(string, uint32, bool) {   
        return(tasks[taskID].taskName, tasks[taskID].timestamp, tasks[taskID].condition);
    }
    
    function allTasks() view public checkOwnerAndAccept returns(task[]) {
        task[] trns;
        for (uint8 nT = 1; nT <= numbersTasks.length; nT++) {
            trns.push(task(tasks[nT].taskName, tasks[nT].timestamp, tasks[nT].condition));
        }
        return trns;
    }
}