

# Pattern: "Canadian-format phone number"

ptrn_phone_number <- "(\\()*[1-9]{3}(\\))*(\\s|-)*[0-9]{3}(\\s|-)*[0-9]{4}"


# Pattern: "letter returned"

ptrn_letter_returned <- paste(
   "(",
   paste("(let(\\.){0,1})", "(let{1,2}er)", "(lt{1,2}r)", sep = "|"),
   ")",
   "[[:space:]]",
   "(",
   paste("(ret(\\.))", "(rtrnd)", "(ret)", sep = "|"),
   ")",
   sep = "" )


# Pattern: "returned payment"

ptrn_returned_payment <- paste(
   "(returned[[:space:]]payment)", "RPAN", "CPAN",
   sep = "|" )


# Pattern: "passport checked/verified"

ptrn_passport_checked <- paste(
   "(check(.*)([[:alpha:]]|[[:space:]])*passport)",
   "(cert(.*)([[:alpha:]]|[[:space:]])*passport)",
   sep = "|" )


# Pattern: "direct deposit"

ptrn_01 <- paste( "(direct deposit)",
                 "(dir. deposit)",
                 "^(dd)\\W",
                 "\\W(dd)\\W",
                 "\\W(dd)$",
                 sep = "|" )

ptrn_02 <- paste( "((\\W)|^)(add|adding|added)(\\W|$)",
                 "((\\W)|^)(change|changing|changed)(\\W|$)",
                 "((\\W)|^)(replace|replacing|replaced)(\\W|$)",
                 "((\\W)|^)(update|updating|updated)(\\W|$)",
                 "((\\W)|^)(correct|correcting|corrected)(\\W|$)",
                 "((\\W)|^)(encode|encoding|encoded)(\\W|$)",
                 "((\\W)|^)(enrol|enrolling|enrolled)(\\W|$)",
                 "((\\W)|^)(issue|issuing|issued)(\\W|$)",
                 sep = "|" )

ptrn_direct_deposit <- paste( paste0("((", ptrn_01, ")", "(.+)", "(", ptrn_02, "))"),
              paste0("((", ptrn_02, ")", "(.+)", "(", ptrn_01, "))"),
              sep = "|" )

rm(ptrn_01, ptrn_02)


# Pattern: "direct foreign deposit"

ptrn_01 <- "((foreign)|(frgn)|(frgn\\.))[[:space:]]"
ptrn_02 <- paste( "(direct deposit)",
                 "(dir. deposit)",
                 "^(dd)\\W",
                 "\\W(dd)\\W",
                 "\\W(dd)$",
                 sep = "|" )

ptrn_foreign_direct_deposit <- paste0("(", ptrn_01, ")", "(", ptrn_02, ")")

rm(ptrn_01, ptrn_02)


# Pattern: "underpayment"

ptrn_underpayment <- "underpayment|underpymt|underpaid|underpay|(u/p)"


# Pattern: "marital status"

# marital status, marriage status, MS, M/S, married, single, common law

ptrn_01 <- "(mar[:alpha:]*[:blank:]stat[:alpha:]*)"
ptrn_02 <- "((^|[:blank:])m(/*)s([:space:]*)[:digit:])"
ptrn_03 <- "((^|[:blank:])é(/*)c([:space:]*)[:digit:])"
ptrn_04 <- "(ét[:alpha:]*[:blank:]civ[:alpha:]*)"

ptrn_marital_status <- paste(ptrn_01, ptrn_02, ptrn_03, ptrn_03, sep = "|")

rm(ptrn_01, ptrn_02, ptrn_03, ptrn_04)


# Pattern: "proof of marriage"

# mariage certificate, marital status certificate,
# proof of marriage, proof of marital status

ptrn_01 <- "(((proof)|(proof of))[:space:]mar[:alpha:]*)"
ptrn_02 <- "(mar[:alpha:]*[:blank:]cert[:alpha:]*)"

ptrn_proof_of_marriage <- paste(ptrn_01, ptrn_02, sep = "|")

rm(ptrn_01, ptrn_02)






# ========================================================================================

all_regex_patterns  = c(

   "Direct Deposit" = ptrn_direct_deposit,
   "Foreign Direct Deposit" = ptrn_foreign_direct_deposit,
   "Letter Returned" = ptrn_letter_returned,
   "Passport Checked/Vertified" = ptrn_passport_checked,
   "Phone Number (Canadian format)" = ptrn_phone_number,
   "Returned Payment" = ptrn_returned_payment,
   "Underpayment" = ptrn_underpayment,
   "Marital Status" = ptrn_marital_status,
   "Proof of Marriage" = ptrn_proof_of_marriage
)

# Remove all objects that start with "ptrn_", keep only the vector 'all_regex_patterns'

rm( list = ls(pattern = "^ptrn_") )
