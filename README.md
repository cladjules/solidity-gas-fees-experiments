# solidity-gas-fees-experiments

**Experiments on optimising gas fees on Solidity**

A few Solidity functions written in different ways,
to highlight how they can easily be optimized in order to reduce gas fees.

You can see the importance of properly using `storage` vs `memory`, storing your variables in `memory` when accessed many times,
and also how important it is to use `packed` structs.

`calculateTotalAllAuctions` will show you to use `memory` for storing large arrays from storage will decrease fees.

`calculateTotalBidsPerAuction` will also highlight the use of `memory` with a more complex example using `mappings`.

`test_5_unpacked_calculateTotalBidsPerAuction` is a very good example on why you should always pack your struct, and you can see how much gas are reduced by doing so.

`transferBid` will highlight using `storage` vs `memory` and depending on how many times your variable is accessed, `storage` may be cheaper sometimes,
that is due to storage variables being cheaper to be accessed once _warm_.

Here are the results with gas fees:
<img width="1017" alt="image" src="https://user-images.githubusercontent.com/7745576/226570821-73cf475e-fa8b-4f57-95da-68b8e9590a27.png">
