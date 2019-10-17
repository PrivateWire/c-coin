pragma solidity >= 0.4.20;

//Import the actual token
import "./DappToken.sol";

contract dappTokenSale {

    //Don't expose the address of admin
    address payable admin;
    DAppToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address _buyer, uint256 _amount);

    // Set token contract in the constructor
    function DappTokenSale(DAppToken _tokenContract, uint256 _tokenPrice) public {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    //Takes two numbers multiplies them
    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {

        //Require that value is equal to tokens
        require(msg.value == multiply(_numberOfTokens, tokenPrice));

        // Check the blance of the buyers tokens is greater than number of tokens requested
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);

        //Transfer the tokens
        require(tokenContract.transfer(msg.sender, _numberOfTokens));

        //Update token amount
        tokensSold += _numberOfTokens;

        //IF ok then sell the sender the number of tokens
        emit Sell(msg.sender, _numberOfTokens);
    }

    //Ending the sale
    function endSale() public {

        //Send remaing dApp Tokens back to admin
        require(msg.sender == admin);

        //Transfer what left and send them back to the admin
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));

        // UPDATE: Let's not destroy the contract here - contract not destroyed.
        // Just transfer the balance to the admin
         admin.transfer(address(this).balance);
    }
}

