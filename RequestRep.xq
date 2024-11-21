(: Get Person Data from ID:)
declare function local:GetPerson($PERSON_ID as xs:string) 
{
  let $person := doc("XMLProject/Person.xml")/PEOPLE/PERSON[contains(string(@ID), $PERSON_ID)]  
  return $person
};

(: Take ID and Return Appropriate Rep's Emails:)
declare function local:RequestRep($PERSON_ID as xs:string) 
{
  (: Get Division ID the person works in:)
  let $div_no := local:GetPerson($PERSON_ID)/DIVISION/@IDREF
  (: Get Division Data from Division ID:)
  for $division in doc("XMLProject/Employer_Divisions.xml")/EMPLOYER_DIVISIONS/DIVISION
  where $division/@DIV_NO = $div_no
  (: Get Rep IDs from Division Data:)
  for $rep_ids in $division/REPRESENTATIVE/string(@IDREF) 
  (: Get Rep Emails from Rep IDs 
  So long as they have fewer than 10 active cases - otherwise they're too busy:)
  let $available_rep_emails := local:GetPerson($rep_ids)
    where number(string($available_rep_emails/CASE_LOAD)) < 10
  return $available_rep_emails/EMAIL
};

local:RequestRep("P123460")