import EmailAddress_Standard
import RFC_1123
import RFC_6531

func emailAddress(displayName: String? = nil, localPart: String, domain: String) throws -> EmailAddress {
    EmailAddress(
        displayName: displayName,
        localPart: try RFC_6531.Mailbox.LocalPart(localPart),
        domain: try RFC_1123.Domain(domain)
    )
}
