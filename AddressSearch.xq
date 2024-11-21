(: Get Addresses that match search
House No has to exactly match or be blank
all others are contains:)
declare function local:AddressSearch($HOUSE_NO, $STREET, $CITY, $COUNTY, $COUNTRY, $POSTCODE as xs:string) 
{
    for $address in doc("XMLProject/Address.xml")/ADDRESS_BOOK/ADDRESS
  where 
  ($address/HOUSE_NO = $HOUSE_NO
  or $HOUSE_NO = "") 
  and contains(string($address/STREET),$STREET)
  and contains(string($address/CITY),$CITY)
  and contains(string($address/COUNTY),$COUNTY)
  and contains(string($address/COUNTRY),$COUNTRY)
  and contains(string($address/POSTCODE),$POSTCODE)
  return $address
};

local:AddressSearch
   ("",	(: House:)
    "",	(: Street:)
    "",	(: City:)
    "",	(: County:)
    "",	(: Country:)
    "")	(: PostCode:)
              