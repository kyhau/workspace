# Find all users without a sso identity

gh api graphql --paginate -f query='
query($endCursor: String) {
  organization(login: "TODO-org-name") {
    samlIdentityProvider {
      ssoUrl,
      externalIdentities(first: 100, after: $endCursor) {
        edges {
          node {
            guid,
            samlIdentity {
              nameId
            }
            user {
              login
            }
          }
        }
        pageInfo{
          hasNextPage,
          endCursor
        }
      }
    }
  }
}
' | jq -r '.data.organization.samlIdentityProvider.externalIdentities.edges[] | select(.node.user.login == null)'
