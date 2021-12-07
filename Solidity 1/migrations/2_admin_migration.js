const AdminControl = artifacts.require('AdminControl')
const NUSBank = artifacts.require('NUSBank')

module.exports = function (deployer, _network, accounts) {
  deployer.deploy(AdminControl, [accounts[0]])
  deployer.deploy(NUSBank, [])
}
