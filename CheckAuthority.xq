let $correct_authority := "P123457"
let $incorrect_authority := "P123458"
let $PERSON_ID := $incorrect_authority


let $required_authority := "CONTACT_EMPL"

(: Get Elected Office ID from Person ID:)
let $elec_office_id := doc("XMLProject/Person.xml")/PEOPLE/PERSON[string(@ID) = $PERSON_ID]/ELECTED_OFFICE/string(@IDREF)

(: Get Elected Office data from EO ID:)
let $elec_office_data:= doc("XMLProject/Elected_Offices.xml")/ELECTED_OFFICES/ELECTED_OFFICE[string(@ID) = $elec_office_id]/string(@AUTHORITY)

(: Check Authority against Given:)
return 
(: You have MAX or needs NONE :)
if (contains($elec_office_data,"ADMIN_ORG") or $required_authority = "NONE") then <Authority>Valid</Authority>

(: You have 2nd highest and needs not MAX:)
else if (contains($elec_office_data,"ADMIN_MEMBER") and $required_authority != "ADMIN_ORG") then <Authority>Valid</Authority>

(: You have 3nd lowest and needs 2st or 3nd:)
else if (contains($elec_office_data,"ADMIN_DIV") and ($required_authority = "ADMIN_DIV") or ($required_authority = "CONTACT_DIV")) then <Authority>Valid</Authority>

(: You have 3rd hi and needs not MAX or 2nd:)
else if (contains($elec_office_data,"CONTACT_EMPL") and ($required_authority != "ADMIN_MEMBER") and ($required_authority != "ADMIN_ORG")) then <Authority>Valid</Authority>
else <Authority>Invalid</Authority>
