pragma solidity >=0.4.20;

contract DAppToken {

//Name
string public name =  "Chaudry Coin";

//Symbol
string public symbol = "CHAUD";

//Supply
uint256 public totalSupply;

//Standard
string public standard =  "DAppToken v1.0";


//transfer
event Transfer(
    address indexed _from,
    address indexed _to,
    uint256 _value
);

//approve
event Approval(
    address indexed _owner,
    address indexed _spender,
    uint256 _value
);

//Key value pair - Responsible for knowning who has what token
mapping(address => uint256) public balanceOf;

//allowance
mapping(address => mapping(address => uint256)) public allowance;

function DappToken(uint256 _initialSupply) public {
    totalSupply = _initialSupply;
    //allocate initial supply
    balanceOf[msg.sender] = _initialSupply;
}

function transfer(address _to, uint256 _value) public returns (bool success) {

        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        //Actually performs transfer
        emit Transfer(msg.sender, _to, _value);

        return true;
    }

// Delegated Transfers

//approve
function approve(address _spender, uint256 _value) public returns (bool success){

// Handle allowance
allowance[msg.sender][_spender] = _value;

//Handle Approve event
emit Approval(msg.sender, _spender, _value);

return true;
}

//transferFrom
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){

//Require from account has enough tokens
require(_value <= balanceOf[_from]);

//Require allowance is big enough => Use mapping to get actual values which are available
require(_value <= allowance[_from][msg.sender]);

//Change balance remove tokens from account and move to recipentent account
balanceOf[_from] -= _value;
balanceOf[_to] += _value;

//Update allowance decrementing value amount from value
allowance[_from][msg.sender] -= _value;

//Call transfer event
emit Transfer(_from, _to, _value);

//Return boolean
return true;
}

}

