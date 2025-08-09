
/// Module: suinigeriaminna
module suinigeriaminna::suinigeriaminna;

use sui::string::{Self, String};
use sui::url::{Self, Url};
use sui::event;


public struct FutMXNft has key, store {
    id: UID,
    name: string,
    description: string,
    url: Url,
}


public struct NFTMinted has copy, drop {
    objectId: ID,
    creator: address,
    name: String,
}


#[allow(lint(self_transfer))]
public fun mint_to_sender(name: vector<u8>, description: vector<u8>, url: vector<u8>, ctx: &mut TxContext){
    let sender = ctx.sender();

    let futmxNft = FutMXNft {
        id: object::new(ctx),
        name: string::utf8(name),
        description: string::utf8(description),
        url: url::new_unsafe_from_bytes(url),
    };

    event::emit(NFTMinted {
        objectId: object::id(&futmxNft),
        creator: sender,
        name: futmxNft.name,
    });

    tramsfer:public_transfer(futmxNft, sender)
}

public fun transfer_to_recipient(nft: FutMXNft, recipient: address){
    transfer::public_transfer(nft, recipient)
}
// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


