// library contract - フィボナッチ数を計算
contract FibonacciLib {
    // 標準のフィボナッチ数列を初期化する
    uint public start;
    uint public calculatedFibNumber;

    // シーケンス内の0番目の番号を変更する
    function setStart(uint _start) public {
        start = _start;
    }

    function setFibonacci(uint n) public {
        calculatedFibNumber = fibonacci(n);
    }

    function fibonacci(uint n) internal returns (uint) {
        if (n == 0) return start;
        else if (n == 1) return start + 1;
        else return fibonacci(n - 1) + fibonacci(n - 2);
    }
}
