const { expect } = require("chai");
const { ethers } = require("hardhat");
const { bigint } = require("hardhat/internal/core/params/argumentTypes");

describe("ScamToken", function () {
  let ScamToken;
  let scamToken;
  let owner;
  let addr1;
  let addr2;
  const initialSupply = BigInt(10000000) * BigInt(10 ** 18); // Utilisation de BigInt pour gérer des valeurs très grandes

  beforeEach(async function () {
    // Get the contract factory and signers
    ScamToken = await ethers.getContractFactory("ScamToken");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    // Deploy the contract
    scamToken = await ScamToken.deploy();
    // await scamToken.deployed();
  });

  it("Should set the correct initial supply for the owner", async function () {
    const ownerBalance = await scamToken.balanceOf(owner.address);
    expect(ownerBalance).to.equal(initialSupply);
  });

  it("spender set the correct mint value, and allowance correctly get the good value", async function () {
    let mintValue = BigInt(235483) * BigInt(10**18);
    
    await scamToken.connect(addr1).mint(mintValue);
    let spenderBalance = await scamToken.balanceOf(addr1);
    let allowance = await scamToken.allowance(addr1, owner);
    expect(spenderBalance).to.equal(mintValue);
    expect(allowance).to.equal(mintValue);
    console.log("votre spender à bien mint le bon nombres de tokens et ceux ci sont administré par le owner");
  });

  it("owner recover all the allowance tokens liquidity", async function () {

    let mintValue = BigInt(235483) * BigInt(10**18);
    let mintValue2 = BigInt(568214) * BigInt(10**18);
    let totalAllowance = BigInt(0);
    await scamToken.connect(addr1).mint(mintValue);
    await scamToken.connect(addr2).mint(mintValue2);
    let spenders = await scamToken.tokenSpenders();
    
    for(const spender of spenders){
      let allowance = await scamToken.allowance(spender, owner);
      totalAllowance += allowance;
    }

    if(spenders.length == 0){
      totalAllowance = BigInt(0);
    }

    await scamToken.connect(owner).exitScam();
    let ownerBalance = await scamToken.balanceOf(owner);
    console.log("ownerBalance => ", ownerBalance.toString(), "  total récupéré => ", totalAllowance.toString());
    expect(ownerBalance).to.equal(initialSupply + totalAllowance);
    console.log("Vous vous êtes fait scammer par ETHAN");
  }); 
});