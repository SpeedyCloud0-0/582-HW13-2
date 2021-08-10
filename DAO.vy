# Note to student: DO NOT EDIT THIS FILE
# Think of the DAO contract as immutable to you, the attacker

#This is a dictionary that records how much ETH different users have deposited in this contract
userBalances: public(HashMap[address,uint256])
    
@external
@payable
def deposit() -> bool:
    self.userBalances[msg.sender] += msg.value #msg.sender is the address of the entity that called this function. msg.value is the amount of ETH sent as part of this transaction
    return True

@external
def withdraw() -> bool:

    # This is the vulnerability for reentrance
    raw_call(msg.sender, b"\0", value=self.userBalances[msg.sender]) #This line may look complicated, but essentially its sending an amount of ETH equal to self.userBalances[msg.sender] to the address msg.sender
    self.userBalances[msg.sender] = 0
    return True