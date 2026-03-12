# HugCoin — Source Verification

Verified source code for the HugCoin contract deployed to Ethereum mainnet on August 23, 2016.

| | |
|---|---|
| **Contract** | [`0xb83CAb8BAbC0B9298dF5D5283c30bF0D89D23b1E`](https://etherscan.io/address/0xb83CAb8BAbC0B9298dF5D5283c30bF0D89D23b1E) |
| **Block** | [2,123,297](https://etherscan.io/block/2123297) |
| **Creation TX** | [`0x55113c4d...`](https://etherscan.io/tx/0x55113c4d832c0542507193c2e12dbc22d42f096b4672c5643d9cf712d66a2840) |
| **Compiler** | Solidity v0.3.5, optimizer enabled |
| **Author** | [Jon Romero](https://github.com/jonromero) ([@jonromero](https://twitter.com/jonromero)) |
| **Original source** | [`jonromero/ethereum_contracts/HugCoin.eth`](https://github.com/jonromero/ethereum_contracts/blob/master/HugCoin.eth) |

## Verify

```bash
./verify.sh
```

Requires `node` and `curl`. Downloads the solc binary automatically on first run.

```
✅ EXACT MATCH
   Runtime bytecode: 1715 bytes
   Compiler: solc v0.3.5+commit.5f97274a (optimizer enabled)
   Contract: 0xb83CAb8BAbC0B9298dF5D5283c30bF0D89D23b1E
```

Also matches exactly with v0.3.3 and v0.3.4 (optimizer enabled). The creation bytecode (3,100 bytes, excluding 96-byte constructor args) is also a byte-perfect match.

## Source

[`HugCoin.sol`](HugCoin.sol) compiles to a byte-perfect match of the on-chain runtime bytecode (1,715 bytes).

The original source was published on [jon.io](https://jon.io/hugcoin.html) and [GitHub](https://github.com/jonromero/ethereum_contracts/blob/master/HugCoin.eth) alongside a blog post explaining the contract. The file is lightly renamed from `.eth` to `.sol` for compiler compatibility; no code changes were made.

## How It Works

HugCoin is an ERC-20-compatible "infinite hug" token with a social twist:

- **Unlimited supply** — everyone can give as many hugs as they want, forever
- **`transfer(address, uint256)`** — mints 1 HugCoin to the recipient (value arg is ignored)
- **`giveHugTo(string name, address _to)`** — mints 1 HugCoin AND permanently records the recipient's name in a `Member[]` array on-chain
- **`hugged(uint256)`** — retrieves a hug record: `{member: address, name: string, memberSince: timestamp}`
- **`totalHuggers()`** — total number of unique addresses ever hugged
- **`destroy()`** — owner-only selfdestruct
- The constructor sent the first hug to Jon Romero himself: `giveHugTo("Jon V", deployer)`

The contract was deployed as version "0.2" of the concept — two earlier iterations (`0xb723...` and `0x84da...`) were deployed and destroyed at blocks 2,104,929 and 2,104,949 before this final version.

## Function Selectors

| Selector | Function |
|----------|----------|
| `06fdde03` | `name()` |
| `33af4b59` | `totalHuggers()` |
| `70a08231` | `balanceOf(address)` |
| `797b0f84` | `giveHugTo(string,address)` |
| `83197ef0` | `destroy()` |
| `95d89b41` | `symbol()` |
| `a9059cbb` | `transfer(address,uint256)` |
| `bf8161de` | `hugged(uint256)` |

## Constructor Arguments

The constructor accepts a `string sym` parameter, which overrides the default symbol `'<3'`. The deployer passed `"🤗"` (hugging face emoji), making the on-chain symbol the 🤗 emoji.

ABI-encoded constructor arg (96 bytes):
```
0000000000000000000000000000000000000000000000000000000000000020  // offset
0000000000000000000000000000000000000000000000000000000000000004  // length: 4 bytes
f09fa49700000000000000000000000000000000000000000000000000000000  // 🤗 (U+1F917, UTF-8: f0 9f a4 97)
```
