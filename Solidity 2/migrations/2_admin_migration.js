const NUSBank = artifacts.require('NUSBank')
const GasOptimisation = artifacts.require('GasOptimisation')
const NUSBankA = artifacts.require('NUSBankActiveAccountHoldersA')
const NUSBankB = artifacts.require('NUSBankActiveAccountHoldersB')

module.exports = function (deployer, _network, accounts) {
  deployer.deploy(NUSBank, [])
  deployer.deploy(GasOptimisation)
  deployer.deploy(NUSBankA, [])
  deployer.deploy(NUSBankB, [])
}
