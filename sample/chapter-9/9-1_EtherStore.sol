contract EtherStore {

    uint256 public withdrawalLimit = 1 ether;                                                                                                  
    mapping(address => uint256) public lastWithdrawTime;
    mapping(address => uint256) public balances;

    function depositFunds() external payable { // 指定金額の預け入れ
        balances[msg.sender] += msg.value; 
    }

    function withdrawFunds (uint256 _weiToWithdraw) public { // 指定金額の引き出し
        require(balances[msg.sender] >= _weiToWithdraw);
        // 引き出す量を制限
        require(_weiToWithdraw <= withdrawalLimit);
        // 引き出しを許可する間隔を制限
        require(now >= lastWithdrawTime[msg.sender] + 1 weeks);
        require(msg.sender.call.value(_weiToWithdraw)()); // ここに脆弱性あり、
        balances[msg.sender] -= _weiToWithdraw;
        lastWithdrawTime[msg.sender] = now;
    }
 }
