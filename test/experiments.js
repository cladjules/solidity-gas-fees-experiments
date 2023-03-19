const chai = require("chai");
const { expect } = chai;
const { utils } = require("ethers");
const helpers = require("@nomicfoundation/hardhat-network-helpers");
const { assert } = require("chai");

const dayInSeconds = 86400;
const depositAmount = utils.parseEther("10");

describe("Experiments", function () {
  let ExperimentsContract;

  beforeEach(async function () {
    const [_, user1] = await ethers.getSigners();

    const ExperimentsContractFactory = await hre.ethers.getContractFactory(
      "Experiments"
    );

    ExperimentsContract = await ExperimentsContractFactory.deploy(
      user1.address
    );

    await ExperimentsContract.deployed();
    expect(ExperimentsContract).to.not.equal(undefined);
  });

  describe("calculateTotalAllAuctions", function () {
    it("expensive", async function () {
      const tx =
        await ExperimentsContract.expensive_calculateTotalAllAuctions();
      await tx.wait();
    });

    it("cheap", async function () {
      const tx = await ExperimentsContract.cheap_calculateTotalAllAuctions();
      await tx.wait();
    });
  });

  describe("calculateTotalBidsPerAuction", function () {
    it("expensive", async function () {
      const tx =
        await ExperimentsContract.expensive_calculateTotalBidsPerAuction();
      await tx.wait();
    });

    it("cheap", async function () {
      const tx = await ExperimentsContract.cheap_calculateTotalBidsPerAuction();
      await tx.wait();
    });
  });

  describe("transferBid", function () {
    it("storage", async function () {
      const tx = await ExperimentsContract.storage_transferBid(1000000);
      await tx.wait();
    });

    it("memory", async function () {
      const tx = await ExperimentsContract.memory_transferBid(1000000);
      await tx.wait();
    });
  });

  describe("transferBid_v2", function () {
    it("storage", async function () {
      const tx = await ExperimentsContract.storage_transferBid_v2(1000000);
      await tx.wait();
    });

    it("memory", async function () {
      const tx = await ExperimentsContract.memory_transferBid_v2(1000000);
      await tx.wait();
    });
  });
});
