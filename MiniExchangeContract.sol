// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract OrdinaryCoin {

    string public name;
    string public symbol;
    uint8 public decimals;

    mapping(address => uint256) public balanceOf;
    address public owner;
    uint256 public totalSupply;

    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        name = "OrdinaryCoin";
        symbol = "ODC";
        decimals = 16;

        owner = msg.sender;
    }

    function mint(uint256 amt) public {
        totalSupply += amt;
        balanceOf[msg.sender] += amt;
    }

    function approve(address to, uint256 amt) public returns(bool) {
        allowance[msg.sender][to] = amt;
        return true;
    }

    function tranfer(address to, uint256 amt) public  returns(bool){
        return helperTranfer(msg.sender, to, amt);
    }

    function tranferFrom(address from, address to, uint256 amt) public returns(bool) {

        if (msg.sender != from) {
            require(allowance[from][msg.sender] >= amt, "Not enough allawance");

            allowance[from][msg.sender] -= amt;
        }

        return  helperTranfer(from, to, amt);
    }

    function helperTranfer(address _from, address _to, uint256 _amt) internal returns(bool) {
        require(balanceOf[_from] >= _amt, "not sufficent balance");
        require(_to != address(0), "can't sent to address(0)");

        balanceOf[_from] -= _amt;
        balanceOf[_to] += _amt;

        return true;
    }
}


contract ExtraOrdinaryCoin {

    uint256 constant MAX_LIMIT = 1000000;
    string public name;
    string public symbol;

    mapping(address => uint256) public balanceOf;
    uint8 public decimal;
    address public owner;
    uint256 public totalSupply;

    address private source;

    mapping(address => mapping(address => uint256)) public allowance;

    constructor(address _source) {
        name = "ExtraOrdinaryCoin";
        symbol = "EOC";

        owner = msg.sender;

        decimal = 16;
        source = _source;
    }

    function approve(address _to, uint256 _amt) public returns(bool){
        allowance[msg.sender][_to] = _amt;
        return true;
    }

    function transfer(address _to, uint256 _amt) public returns(bool) {
        return helperTransfer(msg.sender, _to, _amt);
    }

    function transferFrom(address _from,address _to, uint256 _amt) public returns(bool) {
        
        if (msg.sender != _from) {
            require(allowance[_from][msg.sender] >= _amt, "Not enouth allowance");

            allowance[_from][msg.sender] -= _amt;
        }

        return helperTransfer(_from, _to, _amt);
    }

    function helperTransfer(address from, address to, uint256 amt) internal returns(bool) {
        require(balanceOf[from] >= amt, "Not sufficent balance");
        require(to != address(0), "can't sent to address(0)");

        balanceOf[from] -= amt;
        balanceOf[to] += amt;

        return  true;
    }

    function trade(uint256 amt) public {
        require(totalSupply < MAX_LIMIT, "no more ExtraOrdinaryCoin.");
        (bool ok, ) = source.call(
            abi.encodeWithSignature("tranferFrom(address,address,uint256)", 
            msg.sender, address(this), amt));
        
        require(ok, "call failed");

        totalSupply += amt;
        balanceOf[msg.sender] += amt;
    }
}
