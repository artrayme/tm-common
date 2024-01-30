using {
    cuid,
    managed,
    Currency
} from '@sap/cds/common';

namespace softmeup.tor.model;
type TorCategory : String enum {
    freightUnit = 'FU';
    freightOrder = 'FO';
};

type ItemCategory : String enum {
    product   = 'PRD';
    package   = 'PKG';
    fuRoot    = 'FUR';
    transport = 'AVR';
};

    @assert.unique: {
         torId: [ torId ]
         }
entity TransportationOrders : cuid, managed {
  // key dbkey : UUID; // cuid
  torId : Int64 @title : '{i18n>torId}'  @mandatory;
  torCategory : TorCategory not null;
  executionStatus : String null;
  lifeCycleStatus : Integer enum {
    inProcess = 2;
    completed = 5;
    canceled  = 10;
  };
  items : Composition of many TransportationOrders.Items
                      on items.parent= $self;
  // createdOn : DateTime; // managed
  // changedOn : DateTime; // managed

}

entity TransportationOrders.Items : cuid {
    // key ID : UUID; // cuid
    key parent       : Association to TransportationOrders;
    itemId           : Int64 not null;
    itemParentKey    : Association to TransportationOrders.Items;
    itemCategory     : ItemCategory not null;
    quantityPcsVal   : Integer;
    quantityPcsUni   : String;
    price            : Decimal(9, 2);
    currency         : Currency;
    splitOrigRefItem : Association to TransportationOrders.Items;
    /* productKey       : Association to Product; */
}

/*
entity Product : cuid{
    productName: String;
}


// Enum Example
Status default #RUNNING;
type Status : String enum {
   QUEUED;
   RUNNING;
   FINISHED;
   FAILED;
}
*/

/*
extend TransportationOrders with {
   responsiblePerson: {
       user  : User;
       phone : String;
       email : String;
   };
   businessPartners: Association to many BusinessPartners
                                 on businessPartners.baseDocument = ID;
}

entity BusinessPartners : cuid, managed{
   key baseDocument : UUID;
   name : String;
   address : String;
}
*/
