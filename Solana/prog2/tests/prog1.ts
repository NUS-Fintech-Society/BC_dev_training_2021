import * as anchor from "@project-serum/anchor";
import { Program } from "@project-serum/anchor";
import { Prog1 } from "../target/types/prog1";

describe("prog1", () => {
  // Configure the client to use the local cluster.
  anchor.setProvider(anchor.Provider.env());

  const program = anchor.workspace.Prog1 as Program<Prog1>;

  it("Is initialized!", async () => {
    const [balanceAccount, bump] =
      await anchor.web3.PublicKey.findProgramAddress(
        [program.provider.wallet.publicKey.toBuffer()],
        program.programId
      );

    await program.rpc.initialize(new anchor.BN(100), bump, {
      accounts: {
        authority: program.provider.wallet.publicKey,
        balanceAccount,
        systemProgram: anchor.web3.SystemProgram.programId,
      },
    });

    const accountData = await program.account.balance.fetch(balanceAccount);
    console.log(accountData.balance.toString());

    const otherAccount = anchor.web3.Keypair.generate();

    const airdropSignature = await program.provider.connection.requestAirdrop(
      otherAccount.publicKey,
      anchor.web3.LAMPORTS_PER_SOL
    );
    await program.provider.connection.confirmTransaction(airdropSignature);

    const [toBalanceAccount, toBump] =
      await anchor.web3.PublicKey.findProgramAddress(
        [otherAccount.publicKey.toBuffer()],
        program.programId
      );

    await program.rpc.initialize(new anchor.BN(100), toBump, {
      accounts: {
        authority: otherAccount.publicKey,
        balanceAccount: toBalanceAccount,
        systemProgram: anchor.web3.SystemProgram.programId,
      },
      signers: [otherAccount],
    });


    await program.rpc.transfer(new anchor.BN(50), bump, {
      accounts: {
        authority: program.provider.wallet.publicKey,
        fromAccount: balanceAccount,
        toAccount: toBalanceAccount,
      },
    });

    const toBalance = await program.account.balance.fetch(toBalanceAccount);
    console.log(toBalance.balance.toString());
  });
});
