let $paid := "P123457"
let $due := "P123456"
(:Choose one of the above for Query:) 
let $query := $due

for $eventsLinked in doc("XMLProject/Person.xml")/PEOPLE/PERSON[contains(@ID,$query)	]/EVENT/string(@IDREF)
where starts-with($eventsLinked,"F") 
for $paymentRecords in //CALENDAR/EVENT
where contains($eventsLinked,$paymentRecords/@EVENT_ID) 
return 
if (contains($paymentRecords/@COMPLETION,"DUE")) then <Ineligible>TRUE</Ineligible>
else null