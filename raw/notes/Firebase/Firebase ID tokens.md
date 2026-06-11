Created by Firebase when a user signs in to an application. These tokens are signed JWTs ([JSON Web Token]()) that securely identify a user in a Firebase project. These tokens contain basic profile information for a user, including the user's ID string, which is unique to the Firebase project. Because of the integrity of ID tokens can be verified, you can send them to a backend server to identify the currently signed-in user.

``` json
{
    "uid": "CP2ngnngq7blOPSUJ0zgmjf2NL62",
    "email": "tmwang7324@gmail.com",
    "emailVerified": false,
    "isAnonymous": false,
    "providerData": [
        {
            "providerId": "password",
            "uid": "tmwang7324@gmail.com",
            "displayName": null,
            "email": "tmwang7324@gmail.com",
            "phoneNumber": null,
            "photoURL": null
        }
    ],
    "stsTokenManager": {
        "refreshToken": "AMf-vBwXtpqObGZNFQkOHjj1koTXMj-yBrubfRI-qB0_ieMli9IqNnE8Qu9d0Es-02bt-qehYf7fRAdsdP_prVxbUBYhCeWDSnKaSBxCN7ePv4y644XGGXNXt41yG-btr_sJKfqJ8KILW0muSNwXjLMp9NzexGlPSvv3KGakwjVQJ5MjGt8GxRM5em7zg9bXxE8LnIiwBU_BIh3f7v0pCJJAe6M94oI1lA",
        "accessToken" (Firebase ID Token): "eyJhbGciOiJSUzI1NiIsImtpZCI6ImM5YTBjMWRlYWEyN2JjNjMyNTUzYmM4MWEyMmQ4NzY1MWM3MTMyY2IiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZG9jdWx5emUtODQ2YjEiLCJhdWQiOiJkb2N1bHl6ZS04NDZiMSIsImF1dGhfdGltZSI6MTc3OTgyMDQ3OCwidXNlcl9pZCI6IkNQMm5nbm5ncTdibE9QU1VKMHpnbWpmMk5MNjIiLCJzdWIiOiJDUDJuZ25uZ3E3YmxPUFNVSjB6Z21qZjJOTDYyIiwiaWF0IjoxNzc5ODIwNDc4LCJleHAiOjE3Nzk4MjQwNzgsImVtYWlsIjoidG13YW5nNzMyNEBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsidG13YW5nNzMyNEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.tgFKRWWiFDQGny_1PKCVlPwkjmH682mk8Aw7aj8_wjH_0UfW-7Dk6pwZwBXNrY83OH73fV1y3Cvylf4uh3QhjXI6Xg0CGcJU-3Cj4tPeH0KjvskDnOhTmswymF5b-UqXAYFiSPmxUZ97_YxG8N8oaCXvuFwJUCItJnLzUD0MHf6510MnQRbPN1G2qC07fzml-ieWydwsROvyH03Wy8fZ4-ehnJpda4_Yih1nejWAb8uGqJ8tEwtxMRhcJyDvFbtbMENVS1MZnDJsHibWXm-ThPANWaBJfp7RTB9B48VCz9BhRIu87hwb2Fwu2cfsXnFQyBhQMB4MS9BnQQAaXORfLQ",
        "expirationTime": 1779824079895
    },
    "createdAt": "1779820478741",
    "lastLoginAt": "1779820478741",
    "apiKey": "AIzaSyBiPkl3erQuQ6F_lwBFRXICl-JkoF_QIBI",
    "appName": "[DEFAULT]"
}
```

**Note:** The refreshToken field in the `User` object refers to a long-lived token used by the Firebase client SDK to get new tokens.
## Identity Provider Tokens

Created by federated identity providers, such as Google and Facebook. These tokens can have different formats, but are often OAuth 2.0 access tokens. Apps use these tokens to verify that users have successfully authenticated with the identity provider, and then convert them into credentials usable by Firebase services.


