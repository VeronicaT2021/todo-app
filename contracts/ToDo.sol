pragma solidity ^0.5.0;

contract ToDo {
    struct ToDoItem {
        uint256 id;
        string taskName;
        uint256 status; // 0 - Not started, 1 - In Progress, 2 - Completed, 3 - archived
    }
    ToDoItem[] public items;
    uint256 public nextId = 1;

    function create(string memory name) public {
        items.push(ToDoItem(nextId, name, 0));
        nextId++;
    }

    function read(uint256 id)
        public
        view
        returns (
            uint256,
            string memory,
            uint256
        )
    {
        uint256 i = find(id);
        return (items[i].id, items[i].taskName, items[i].status);
    }

    function updateName(uint256 id, string memory name) public {
        uint256 i = find(id);
        items[i].taskName = name;
    }

    function updateStatus(uint256 id, uint256 status) public {
        uint256 i = find(id);
        items[i].status = status;
    }

    function destroy(uint256 id) public {
        uint256 i = find(id);
        delete items[i];
    }

    function find(uint256 id) private view returns (uint256) {
        for (uint256 i = 0; i < items.length; i++) {
            if (items[i].id == id) {
                return i;
            }
        }
        // if id not found, revert
        revert("Item does not exist");
    }
}
