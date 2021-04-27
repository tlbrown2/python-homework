pragma solidity ^0.5.0;

// lvl 3: equity plan
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";

contract DeferredEquityPlan {
    using SafeMath for uint;
    
    address human_resources;

    address payable employee; // bob
    bool active = true; // this employee is active at the start of the contract

    // @TODO: Set the total shares and annual distribution
    uint total_shares = 1000;
    uint annual_distribution = 250;
    uint distribution_years = total_shares.div(annual_distribution);

    uint start_time = now; // permanently store the time this contract was initialized

    // @TODO: Set the `unlock_time` to be 365 days from now
    uint unlock_time = now.add(365 days);

    uint public distributed_shares; // starts at 0

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract not active.");

        // @TODO: Add "require" statements to enforce that:
        // 1: `unlock_time` is less than or equal to `now`
        require(unlock_time <= now, "The unlock time is in the future!! It should be before now!");
        
        // 2: `distributed_shares` is less than the `total_shares`
        require(distributed_shares < total_shares, "Error: The distributed_shares are larger than the total # of shares!");

        // @TODO: Add 365 days to the `unlock_time`
        unlock_time = unlock_time.add(365 days);

        // @TODO: Calculate the shares distributed by using the function (now - start_time) / 365 days * the annual distribution
        // Make sure to include the parenthesis around (now - start_time) to get accurate results!
        uint distributed_shares1 = now.sub(start_time);
        uint distributed_shares2 = annual_distribution.mul(365 days);
        distributed_shares = distributed_shares1.div(distributed_shares2);

        // double check in case the employee does not cash out until after 5+ years
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    // human_resources and the employee can deactivate this contract at-will
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to deactivate this contract.");
        active = false;
    }

    // Since we do not need to handle Ether in this contract, revert any Ether sent to the contract directly
    function() external payable {
        revert("Do not send Ether to this contract!");
    }
}
