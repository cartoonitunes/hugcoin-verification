contract HugCoin {
    
    string public name = 'HugCoin';
    string standard = 'HugCoin 0.2';
    string public symbol = '<3';
    uint8 decimals = 0;
    address owner;
    
    uint8 constant a_hug = 1;
    uint public totalHuggers = 0;

    Member[] public hugged;
    mapping (address => uint256) public balanceOf; 
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
    struct Member {
        address member;
        string name;
        uint memberSince;
    }

    modifier isOwner {
        if (msg.sender != owner) throw;
        _
    }
        
    function HugCoin(string sym) {
        symbol = sym;
        owner = msg.sender;
        
        giveHugTo("Jon V", msg.sender);
        msg.sender.send(msg.value);                         
    }

    function transfer(address _to, uint256 _value) returns (bool success) {
        balanceOf[_to] += a_hug;
        totalHuggers += 1;

        Transfer(msg.sender, _to, a_hug);
        
        return true;
    }

    function giveHugTo(string receipient_name, address _to) returns (bool success){
        if (balanceOf[_to] == 0) {
            hugged[hugged.length++] = Member({member: _to, name:receipient_name, memberSince: now});
            balanceOf[_to] = a_hug;
            totalHuggers += 1;
        }
        else {
            balanceOf[_to] += a_hug;
        }
        
        Transfer(msg.sender, _to, a_hug);
        return true;
    }

    function destroy() isOwner {
        suicide(owner);
    }
   
    function () {
        throw;
    }
}
