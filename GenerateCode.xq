(: Use a Hashing algo to anonymise IDs:)
declare function local:GenerateCode($input as xs:string) {
  let $prime1 := 31
  let $prime2 := 37
  let $multiplier := 123456789
  (: Sum the characters of the input:)
  let $sum := sum(string-to-codepoints($input))
  let $hashed := ($sum * $prime1 + $prime2 + number($input) * $multiplier)
  return ($hashed mod 1000000)
};

let $PERSON_ID := "P123458"
(: Remove the P from all IDs before hash :)
let $number := substring-after($PERSON_ID,'P')
return <hash>{local:GenerateCode($number)}</hash>