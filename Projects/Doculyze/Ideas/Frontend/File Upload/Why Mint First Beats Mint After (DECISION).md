I, at first, wanted to skip the extra Firestore write by choosing a **Mint After** approach to Google Cloud Service (GCS) file upload. However, I realized there are more disadvantages than advantages to this approach, so I redid it.
# Mint After 
### Advantages
**Greater Efficiency:** It genuinely does exclude a write query to Firestore that would otherwise be present in the **First Mint** workflow. Furthermore, it saves Firestore space by only creating entries of documents that pass through the `PUT` request and are size consistent.


### Disadvantages
**Orphaned Storage Objects:** If the cookie expires, client closes session, or `finalizeUpload` throws an error, then there is no Firestore entry that corresponds to the uploaded document in Firebase Storage. This makes clean up a bucket walk, which is much more inefficient than a Firestore reference.
**Inconsistent Error Handling with Python workers:** If embedding or NER/sentiment analysis fails, then the record status in Firebase must be updated [[RAG Pipeline#Firestore Minting]]


# Mint Before
### Advantages
**No Orphaned Storage Objects:** Every upload attempt has a dedicated Firestore entry, so even if `finalizeUpload` is never called, there is a refernce to the uploaded document in GCS