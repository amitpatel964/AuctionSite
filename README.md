# AuctionSite

Checklist

I. Auctions <br/>
 [X] seller creates auctions and posts items for sale <br/>
    ---[X] set all the characteristics of the item <br/>
    ---[X] set closing date and time <br/>
    ---[X] set a hidden minimum price (reserve) <br/>
 [X] a buyer should be able to bid <br/>
     ---[X] let the buyer set a new bid <br/>
     ---[X] in case of automatic bidding set secret upper limit and bid increment <br/>
     ---[X] alert other buyers of the item that a higher bid has been placed (manual) <br/>
     ---[X] alert buyers in case someone bids more than their upper limit (automatic) <br/>
 [X] define the winner of the auction <br/>
     ---[X] when the closing time has come, check if the seller has set a reserve <br/>
     ------[X] if yes: if the reserve is higher than the last bid none is the winner. <br/>
     ------[X] if no: whoever has the higher bid is the winner <br/>
     ---------[X] alert the winner that they won the auction <br/>
 
II. Browsing and advanced search functionality <br/>
    ---[X] let people browse on the items and see the status of the current bidding <br/>
    ---[X] sort by different criteria (by type, bidding price etc.) <br/>
    ---[X] search the list of items by various criteria. <br/>
    ---[] a user should be able to: <br/>
    ------[X] view all the history of bids for any specific auction <br/>
    ------[X] view the list of all auctions a specific buyer or seller has participated in <br/>
    ------[] view the list of "similar" items on auctions in the preceding month (and auction information about them) <br/>
    ---[] let user set an alert for specific items s/he is interested <br/>
    ------[] get an alert when the item becomes available <br/>
    ---[] users browse questions and answers <br/>
    ---[] users search questions by keywords <br/>
 
I||. Admin and customer rep functions <br/>
    ---[X] Admin (create an admin account ahead of time) <br/>
    ------[X] creates accounts for customer representatives <br/>
    ------[] generates sales reports for: <br/>
    ---------[] total earnings <br/>
    ---------[] earnings per: <br/>
    ------------[] item <br/>
    ------------[] item type <br/>
    ------------[] end-user <br/>
    ------------[] best-selling items <br/> 
    ------------[] best buyers <br/>
    ---[] Customer representative functions: <br/>
    ------[] users post questions to the customer representatives (i.e. customer service) <br/>
    ------[] reps reply to user questions <br/>
    ------[] edits and deletes account information <br/>
    ------[] removes bids <br/>
    ------[] removes auctions <br/>
