(:~LUPUS WAS HERE 
     _                  _
    | '-.            .-' |
    | -. '..\\,.//,.' .- |
    |   \  \\\||///  /   |
   /|    )M\/%%%%/\/(  . |\
  (/\  MM\/%/\||/%\\/MM  /\)
  (//M   \%\\\%%//%//   M\\)
(// M________ /\ ________M \\)
 (// M\ \(',)|  |(',)/ /M \\) \\\\  
  (\\ M\.  /,\\//,\  ./M //)
    / MMmm( \\||// )mmMM \  \\
     // MMM\\\||///MMM \\ \\
      \//''\)/||\(/''\\/ \\
      mrf\\( \oo/ )\\\/\
           \'-..-'\/\\
              \\/ \\

~:)

(: LOCAL FUNCTION TO GET PERSON DATA from DB :)
declare function local:GetPerson($PERSON_ID as xs:string) 
{
  let $person := doc("XML_Project/Person.xml")/PEOPLE/PERSON[contains(string(@ID), $PERSON_ID)]  
  return $person
};

(: LOCAL FUNCTION TO GET ADDRESS DATA from DB :)
declare function local:GetAddress($ADDRESS_ID as xs:string) 
{
  let $address := doc("XML_Project/Address.xml")/ADDRESS_BOOK/ADDRESS[contains(string(@ADDRESS_ID), $ADDRESS_ID)]  
  return $address
};

(: LOCAL FUNCTION TO GET EVENT DATA from DB :)
declare function local:GetEvents($EVENT_ID as xs:string) 
{
  let $event := doc("XML_Project/Calendar.xml")/CALENDAR/EVENT[contains(string(@EVENT_ID), $EVENT_ID)]  
  return $event
};

(: Request Data from Everywhere in the database:)
let $PERSON_ID := "P387263" (: PERSON WE WANT TO COLLECT GDPR DATA :)

(: CREATE VARIABLES FOR GDPR DATA AND CALL THE PREVIOUS LOCAL FUNCTIONS TO GET PERSON DATA :)
let $data := local:GetPerson($PERSON_ID)
let $address := local:GetAddress($data/ADDRESS/string(@IDREF))
let $events := local:GetEvents($data/EVENT/string(@IDREF))

(: Retrieve and Combine Data from Everywhere in the database :)

return (: RETURN PERSON DATA COLLECTED FOR GDPR :)
(:~
  XML Tree Structure:

  <RESULT> => ROOT NODE
  <PERSON_DATA>, <ADDRESS_DATA>, <EVENTS> => CHILD NODES
  $data, $address, $events => Variables with the query results to return.

 ~:)

<RESULT>
    <PERSON_DATA> 
      {$data} 
    </PERSON_DATA>
    <ADDRESS_DATA> 
      {$address} 
    </ADDRESS_DATA>
    <EVENTS> 
      {$events} 
    </EVENTS>
</RESULT>