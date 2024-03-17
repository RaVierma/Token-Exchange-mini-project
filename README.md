# Token-Exchange-mini-project
In this contract, show the simple Exchange of token between two contract.Anyone can mint OrdinaryCoin, but the only way to obtain ExtraOrdinaryCoin is to send OrdinaryCoin to the ExtraOrdinaryCoin contract.


Following are the flow:- 
* any one mint(uint256 amount) the OrdinaryCoin token.
* OrdinaryCoin.approve(address extraOrdinaryCoinAddress, uint256 yourBalanceOfOrdinaryCoin) ExtraOrdinaryCoin to take coins from you.
* ExtraOrdinaryCoin.trade() This will cause ExtraOrdinaryCoin to OrdinaryCoin.transferFrom(address you, address RareCoin, uint256 yourBalanceOfSkillsCoin).
* ExtraOrdinaryCoin.balanceOf(address you) return the amount of coin you originally minted for OrdinaryCoin.