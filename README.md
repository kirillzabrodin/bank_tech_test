# Bank Tech Test
This is a small project that will serve as practice for future tech tests. I will make a small applet that will allow a user to deposit money into the account and take money out for the specifications of the client.

### Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2012  
**And** a deposit of 2000 on 13-01-2012  
**And** a withdrawal of 500 on 14-01-2012  
**When** she prints her bank statement  
**Then** she would see

```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```

### Installation and running tests
- Clone the repo and rub ```bundle```.
- Run RSpec to check tests.
- Enjoy!

### Usage
Run
```
rspec
rubocop
```
in the project directory to run the tests and the linter respectively.


Create a new bank class object for yourself with
``` your_name = Bank.new ```

You can use ```.status``` on the object to get the statement and ```.credit```/```.debit``` to add or withdraw money.

I ended up adding the time in minutes for when the transaction occured.

### Contributing

Make a pull request with passing tests and linter and I can approve it!
