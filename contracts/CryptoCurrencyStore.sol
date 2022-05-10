// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoCurrencyStore {
    mapping(address => uint256) public balances;
    event DepositLog(address sender);

    function deposit() public payable {
        balances[msg.sender] += msg.value; //存款
        emit DepositLog(msg.sender);
    }

    bool public lockedState; // false

    function withdraw() public {
        uint256 userBalance = balances[msg.sender]; //取得使用者存款資金
        require(userBalance > 0); //檢查使用者的存款資金是否大於0
        (bool sent, ) = msg.sender.call{value: userBalance}(""); //這段會觸發攻擊者的fallback
        require(sent, "Failed to send Ether"); //sent如為false代表使用者取款失敗
        balances[msg.sender] = 0; //資金領取完畢，將餘額設置為0。
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getContractAddress() public view returns (address) {
        return address(this);
    }
}
