let $high_income := "P123461"
let $low_income := "P728375"
let $PERSON_ID := $low_income

let $percentage := 0.005
let $person := number(doc("XMLProject/Person.xml")/PEOPLE/PERSON[string(@ID) = $PERSON_ID]/SALARY) * $percentage div 24
return 
if ($person > 12.5) then 12.5
else fn:round($person,2)