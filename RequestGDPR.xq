(: PERSON DATA :)
declare function local:GetPerson($PERSON_ID as xs:string) 
{
  let $person := doc("XML_Project/Person.xml")/PEOPLE/PERSON[contains(string(@ID), $PERSON_ID)]  
  return $person
};

(: ADDRESS DATA :)
declare function local:GetAddress($ADDRESS_ID as xs:string) 
{
  let $address := doc("XML_Project/Address.xml")/ADDRESS_BOOK/ADDRESS[contains(string(@ADDRESS_ID), $ADDRESS_ID)]  
  return $address
};

(: EVENT DATA :)
declare function local:GetEvents($EVENT_IDS as xs:string+) 
{
  for $event_id in $EVENT_IDS
  for $event in doc("XML_Project/Calendar.xml")/CALENDAR/EVENT
    where contains($event/@EVENT_ID,$event_id)  
  return $event
};

(: Request Data from Everywhere:)
let $PERSON_ID := "P123461"
let $data := local:GetPerson($PERSON_ID)
let $address := local:GetAddress($data/ADDRESS/string(@IDREF))
let $events := local:GetEvents($data/EVENT/string(@IDREF))

(: Combine Data from Everywhere :)
return
<RESULT>
    <PERSON_DATA>
      {$data}
    </PERSON_DATA>
    space
    <ADDRESS_DATA>
      {$address}
    </ADDRESS_DATA>
    space
    <EVENTS>
      {$events}
    </EVENTS>
  </RESULT>