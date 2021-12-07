export async function isEthEnabled(window) {
  if (window.web3) {
    window.web3 = new Web3(window.web3.currentProvider)
    window.ethereum.enable()
    return true
  }
  return false
}
