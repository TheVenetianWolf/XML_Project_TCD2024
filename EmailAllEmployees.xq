(: Get Email from Employee ID Function:)
declare function local:GetEmail($PERSON_ID as xs:string) 
{
  for $person in doc("XMLProject/Person.xml")/PEOPLE/PERSON
  where $person[string(@ID) = $PERSON_ID]
  and $person[string(@CONTACT_PREFERENCE) = "EMAIL"]
  return $person/EMAIL
};

(: Company No -> Division Nos:)
let $company_no := "R514293"
for $divisions in doc("XMLProject/Employer_Divisions.xml")/EMPLOYER_DIVISIONS/EMPLOYER
where $divisions/string(@COMPANY_NO) = $company_no 
for $div_nos in tokenize($divisions/@DIV_NOS)

(: Division Nos -> Employee IDs:)
for $division_info in doc("XMLProject/Employer_Divisions.xml")/EMPLOYER_DIVISIONS/DIVISION
where $division_info/string(@DIV_NO) = $div_nos
for $employees in $division_info/MEMBER

(: Plug Employee IDs into top function:)
return local:GetEmail($employees/string(@IDREF))