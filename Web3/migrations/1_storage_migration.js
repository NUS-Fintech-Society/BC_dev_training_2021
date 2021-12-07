const Migrations = artifacts.require('IntStorage')

module.exports = function (deployer) {
  deployer.deploy(Migrations)
}
