contract EtherStore {

    // ミューテックスを初期化する
    bool reEntrancyMutex = false;
    uint256 public withdrawalLimit = 1 ether;
    mapping(address => uint256) public lastWithdrawTime;
    mapping(address => uint256) public balances;

    function depositFunds() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawFunds (uint256 _weiToWithdraw) public {
        require(!reEntrancyMutex);
        require(balances[msg.sender] >= _weiToWithdraw);
        // 引き出しを制限する
        require(_weiToWithdraw <= withdrawalLimit);
        // 引き出し可能時間を制限する
        require(now >= lastWithdrawTime[msg.sender] + 1 weeks);
        balances[msg.sender] -= _weiToWithdraw;
        lastWithdrawTime[msg.sender] = now;
        // 外部呼び出しの前にreEntrancyミューテックスを設定する
        reEntrancyMutex = true;
        msg.sender.transfer(_weiToWithdraw);
        // 外部呼び出しの後にミューテックスを解放する
        reEntrancyMutex = false;                                                                                                               
    }
 }
