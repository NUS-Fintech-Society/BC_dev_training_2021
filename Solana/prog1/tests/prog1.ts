import * as anchor from "@project-serum/anchor";
import { Program } from "@project-serum/anchor";
import { Prog1 } from "../target/types/prog1";

describe("prog1", () => {
  // Configure the client to use the local cluster.
  anchor.setProvider(anchor.Provider.env());

  const program = anchor.workspace.Prog1 as Program<Prog1>;

  it("Is initialized!", async () => {

    const stateAccount = anchor.web3.Keypair.generate();

    const tx = await program.rpc.initialize(Buffer.from("abcdef"), {
      accounts: {
        authority: program.provider.wallet.publicKey,
        stateAccount: stateAccount.publicKey,
        systemProgram: anchor.web3.SystemProgram.programId,
      },
      signers: [stateAccount],
    });
    console.log("Your transaction signature", tx);

    const accountData = await program.account.accountData.fetch(stateAccount.publicKey);
    console.log(accountData.content.toString());
  });
});
