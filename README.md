This repo is for review of requests for signing shim. To create a request for review:

- clone this repo (preferably fork it)
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push it to GitHub
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so
asking us to endorse anything else for signing is going to require some convincing on
your part.

As of 27 June 2026, shims sent to Microsoft can only be signed by the Microsoft UEFI CA 2023. It is no longer possible to get your shim signed by the "old" Microsoft Corporation UEFI CA 2011 key. Up-to-date information from Microsoft about Secure Boot can be found here: https://support.microsoft.com/en-US/servicing/os/secure-boot/2026/02/updates-and-announcements

New signing requirements have also taken effect, and are available here: https://techcommunity.microsoft.com/blog/hardware-dev-center/updated-microsoft-uefi-signing-requirements/1062916 Please note that undergoing this shim review exempts you from yearly security audits, as long as your shim only hands off to open source boot loaders.

Hint: check the [docs](./docs/) directory in this repo for guidance on submission and getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
Organization name and website:  
BUTTERFLY INTERACTION, INC. [ https://www.butterfly.so/]

*******************************************************************************
### What's the legal data that proves the organization's genuineness?
The reviewers should be able to easily verify, that your organization is a legal entity, to prevent abuse.
Provide the information, which can prove the genuineness with certainty.
*******************************************************************************
Company/tax register entries or equivalent:  
(a link to the organization entry in your jurisdiction's register will do)  

- Delaware Division of Corporations - file number 10385802. Incorporated October 30, 2025.
Search: https://icis.corp.delaware.gov/ecorp/entitysearch/namesearch.aspx
    - File Number: 10385802, Entity Name: BUTTERFLY INTERACTION, INC., Entity Kind: Corporation, Residency: Domestic, Incorporation Date / Formation Date: 10/30/2025, Entity Type: General, State: Delaware
- California Secretary of State - corporation number **8491954**. Registered in California as a foreign corporation on January 20, 2026.
Search: https://bizfileonline.sos.ca.gov/search/business

Note that the same registration number 10385802 appears as the serialNumber field in the EV certificate subject below.

The public details of both your organization and the issuer in the EV certificate used for signing .cab files at Microsoft Hardware Dev Center File Signing Services.  
(**not** the CA certificate embedded in your shim binary)

Example:

```
Issuer: O=MyIssuer, Ltd., CN=MyIssuer EV Code Signing CA
Subject: C=XX, O=MyCompany, Inc., CN=MyCompany, Inc.
```

```html
Issuer:  C = US, O = DigiCert, Inc., CN = DigiCert Trusted G4 Code Signing RSA4096 SHA384 2021 CA1
Subject: serialNumber = 10385802, jurisdictionC = US, jurisdictionST = Delaware,
         businessCategory = Private Organization, C = US, ST = California,
         L = San Francisco, O = BUTTERFLY INTERACTION, INC., CN = BUTTERFLY INTERACTION, INC.
```

*******************************************************************************
### What product or service is this for?
*******************************************************************************
Pond

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
Our Windows installer makes installing Linux much easier, like installing an app, and so it brings in many non-technical users. The biggest complaint we've heard from them is the step where they disable Secure Boot in BIOS being very difficult. Roughly half of the attempted installs fail to get past that stage. So secure boot has been our highest priority here. We also want to provide an easy and secure experience for our security-conscious users and gamers. TPM-backed FDE is also planned.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
Pond is Arch-based, and uses our own GRUB and kernel.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
Please upload the PGP keys to a well-known keyserver like keyserver.ubuntu.com and/or include them in the review as an .asc file, and point to them here.

*******************************************************************************
- Name: Ammar Hossain
- Position: CTO
- Email address: ammar@butterfly.so
- PGP key fingerprint: C92269F1F75FBFAF6D6EA0B2034AAA38210EB1DB
- File/keyserver location: https://keyserver.ubuntu.com/pks/lookup?search=0xc92269f1f75fbfaf6d6ea0b2034aaa38210eb1db&op=index

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Taha Hossain
- Position: CEO
- Email address: taha@butterfly.so
- PGP key fingerprint: 5CFE8605FEE7F653C8F680A67D5C9F2439F211DA
- File/keyserver location: https://keyserver.ubuntu.com/pks/lookup?search=0x5cfe8605fee7f653c8f680a67d5c9f2439f211da&op=index

*******************************************************************************
### Were these binaries created from the 16.1 shim release tar?
Please create your shim binaries starting with the 16.1 shim release tar file: https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/16.1 and contains the appropriate gnu-efi source.

Make sure the tarball is correct by verifying your download's checksum
(SHA256, SHA512) with the following ones:

```
46319cd228d8f2c06c744241c0f342412329a7c630436fce7f82cf6936b1d603  shim-16.1.tar.bz2
ca5f80e82f3b80b622028f03ef23105c98ee1b6a25f52a59c823080a3202dd4b9962266489296e99f955eb92e36ce13e0b1d57f688350006bba45f2718f159fb  shim-16.1.tar.bz2
```

Make sure that you've verified that your build process uses that file
as a source of truth (excluding external patches) and its checksum
matches. You can also further validate the release by checking the PGP
signature: there's [a detached
signature](https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2.asc)

The release is signed by the maintainer Peter Jones - his master key
has the fingerprint `B00B48BC731AA8840FED9FB0EED266B70F4FEF10` and the
signing sub-key in the signature here has the fingerprint
`02093E0D19DDE0F7DFFBB53C1FD3F540256A1372`. A copy of his public key
is included here for reference:
[pjones.asc](https://github.com/rhboot/shim-review/blob/main/pjones.asc)

Once you're sure that the tarball you are using is correct and
authentic, please confirm this here with a simple *yes*.

A short guide on verifying public keys and signatures should be available in the [docs](./docs/) directory.
*******************************************************************************
Yes.

*******************************************************************************
### URL for a repo that contains the exact code which was built to result in your binary:
Hint: If you attach all the patches and modifications that are being used to your application, you can point to the URL of your application here (*`https://github.com/YOUR_ORGANIZATION/shim-review`*).

You can also point to your custom git servers, where the code is hosted.
*******************************************************************************
https://github.com/rhboot/shim/tree/16.1

*******************************************************************************
### What patches are being applied and why:
Mention all the external patches and build process modifications, which are used during your building process, that make your shim binary be the exact one that you posted as part of this application.
*******************************************************************************
No external patches or build process modifications.

*******************************************************************************
### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522 for more details on the signing of shim without NX bit.
*******************************************************************************
No.

*******************************************************************************
### What exact implementation of Secure Boot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
Skip this, if you're not using GRUB2.
*******************************************************************************
Upstream GRUB2 shim_lock verifier.

*******************************************************************************
### Do you have fixes for all the following GRUB2 CVEs applied?
**Skip this, if you're not using GRUB2, otherwise make sure these are present and confirm with _yes_.**

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
* February 2025
  * Details: https://lists.gnu.org/archive/html/grub-devel/2025-02/msg00024.html, SBAT increase to 5
  * CVE-2024-45774
  * CVE-2024-45775
  * CVE-2024-45776
  * CVE-2024-45777
  * CVE-2024-45778
  * CVE-2024-45779
  * CVE-2024-45780
  * CVE-2024-45781
  * CVE-2024-45782
  * CVE-2024-45783
  * CVE-2025-0622
  * CVE-2025-0624
  * CVE-2025-0677
  * CVE-2025-0678
  * CVE-2025-0684
  * CVE-2025-0685
  * CVE-2025-0686
  * CVE-2025-0689
  * CVE-2025-0690
  * CVE-2025-1118
  * CVE-2025-1125
*******************************************************************************
Yes.

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 5?
Skip this, if you're not using GRUB2, otherwise do you have an entry in your GRUB2 binary similar to:  
`grub,5,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`?
*******************************************************************************
The SBAT generation is set to [7](https://github.com/bflycomputer/pond-pkgbuilds/blob/main/grub/sbat.csv).

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
If you had no previous signed shim, say so here. Otherwise a simple _yes_ will do.
*******************************************************************************
No previous signed shim.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
Hint: upstream kernels should have all these applied, but if you ship your own heavily-modified older kernel version, that is being maintained separately from upstream, this may not be the case.  
If you are shipping an older kernel, double-check your sources; maybe you do not have all the patches, but ship a configuration, that does not expose the issue(s).
*******************************************************************************
Yes.

*******************************************************************************
### How does your signed kernel enforce lockdown when your system runs with Secure Boot enabled?
Hint: If it does not, we are not likely to sign your shim.
*******************************************************************************
CONFIG_LOCK_DOWN_IN_EFI_SECURE_BOOT=y enabled at buildtime in the PKGBUILD + 3 lockdown patches from Debian.
https://github.com/bflycomputer/pond-pkgbuilds/blob/main/linux-pond/patches/efi-add-an-efi_secure_boot-flag-to-indicate-secure-b.patch
https://github.com/bflycomputer/pond-pkgbuilds/blob/main/linux-pond/patches/efi-lock-down-the-kernel-if-booted-in-secure-boot-mo.patch
https://github.com/bflycomputer/pond-pkgbuilds/blob/main/linux-pond/patches/mtd-disable-slram-and-phram-when-locked-down.patch

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
Yes. Selected performance tweaks, mainline backports, and hardware fixes from the CachyOS kernel (and lockdown patches of course).
See patches here (7.3):
https://github.com/bflycomputer/pond-pkgbuilds/tree/main/linux-pond/patches
LTS (6.18) kernel contains mainline patches + a subset of patches in the 7.3 kernel:
https://github.com/bflycomputer/pond-pkgbuilds/tree/main/linux-pond-lts/patches

NVIDIA's open kernel modules (out of tree) are built with the kernel, signed with the same ephemeral key.

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
Yes

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
We don't use vendor_db.

*******************************************************************************
### If you are re-using the CA certificate from your last shim binary, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs mentioned earlier to vendor_dbx in shim. Please describe your strategy.
This ensures that your new shim+GRUB2 can no longer chainload those older GRUB2 binaries with issues.

If this is your first application or you're using a new CA certificate, please say so here.
*******************************************************************************
First application.

*******************************************************************************
### Is the Dockerfile in your repository the recipe for reproducing the building of your shim binary?
A reviewer should always be able to run `docker build .` to get the exact binary you attached in your application.

Hint: Prefer using *frozen* packages for your toolchain, since an update to GCC, binutils, gnu-efi may result in building a shim binary with a different checksum.

If your shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case, what the differences would be and what build environment (OS and toolchain) is being used to reproduce this build? In this case please write a detailed guide, how to setup this build environment from scratch.
*******************************************************************************
Yes `docker build .` works.

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
`build.log`

*******************************************************************************
### What changes were made in the distro's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..

Skip this, if this is your first application for having shim signed.
*******************************************************************************
This is our first application.

*******************************************************************************
### What is the SHA256 hash of your final shim binary?
*******************************************************************************
`1888b15d17719bf09acaa630483368343dd6933f1c99cce49e008282c642e160  shimx64.efi`

*******************************************************************************
### How do you manage and protect the keys used in your shim?
Describe the security strategy that is used for key protection. This can range from using hardware tokens like HSMs or Smartcards, air-gapped vaults, physical safes to other good practices.
*******************************************************************************
We store our CA and signing key in a FIPS 140-2 Level 3 validated HSM hosted by GCP. HSM activity gets logged and access is restricted.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the shim?
A _yes_ or _no_ will do. There's no penalty for the latter.
*******************************************************************************
No.

*******************************************************************************
### Are you embedding a CA certificate in your shim?
A _yes_ or _no_ will do. There's no penalty for the latter. However,
if _yes_: does that certificate include the X509v3 Basic Constraints
to say that it is a CA? See the [docs](./docs/) for more guidance
about this.
*******************************************************************************
Yes, and includes the X509v3 Basic Constraints to say that it is a CA.
```
X509v3 Basic Constraints: critical
    CA:TRUE
```

*******************************************************************************
### What certificates are embedded in your shim, and what are their key types and sizes?
For each certificate embedded in your shim, state whether it is newly
embedded in your shim or reused unchanged from your last accepted shim.
For each certificate in your shim, provide its algorithm
and key size.

Certificates newly embedded in your shim must use an RSA key with a modulus
of at least 4096 bits. Existing vendors reusing a certificate unchanged
are not required to replace it, but are strongly encouraged to replace
smaller RSA keys with 4096-bit or larger keys when they have an
appropriate opportunity to do so.
*******************************************************************************
One newly embedded certificate, `pond.cer`, which uses a 4096-bit RSA key.
```
Public Key Algorithm: rsaEncryption
    Public-Key: (4096 bit)
```

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide the exact SBAT entries for all binaries you are booting directly through shim.
Hint: The history of SBAT and more information on how it works can be found [here](https://github.com/rhboot/shim/blob/main/SBAT.md). That document is large, so for just some examples check out [SBAT.example.md](https://github.com/rhboot/shim/blob/main/SBAT.example.md)

If you are using a downstream implementation of GRUB2 (e.g. from Fedora or Debian), make sure you have their SBAT entries preserved and that you **append** your own (don't replace theirs) to simplify revocation.

**Remember to post the entries of all the binaries. Apart from your bootloader, you may also be shipping e.g. a firmware updater, which will also have these.**

Hint: run `objcopy --dump-section .sbat=/dev/stdout YOUR_EFI_BINARY` to get these entries. Paste them here. Preferably surround each listing with three backticks (\`\`\`), so they render well.
*******************************************************************************
Yes.

shim:
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.pond,1,Pond,shim,16.1,mail:security@butterfly.so
```

GRUB:
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,7,Free Software Foundation,grub,2.16,https://www.gnu.org/software/grub/
grub.pond,1,Pond,grub,2:2.16-1,mail:security@butterfly.so
```

*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
Skip this, if you're not using GRUB2.

Hint: this is about those modules that are in the binary itself, not the `.mod` files in your filesystem.
*******************************************************************************
We load 29 modules explicitly (60 total with dependencies). All modules in the list are also in Debian except for tar and efibootnext.
```
normal configfile echo test search linux chain efifwsetup loadenv
efibootnext reboot
part_gpt part_msdos fat btrfs ext2
gfxterm gfxmenu png font efi_gop all_video
memdisk tar
search_fs_uuid boot gzio gettext terminal
```
*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************
We do not use systemd-boot.

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************
Upstream GRUB 2.16

https://github.com/bflycomputer/pond-pkgbuilds/tree/main/grub

Our grub is based off of the Arch Linux PKGBUILD, modified for secure boot. It contains 3 benign patches for configuration from Arch:

[0001: let /etc/default/grub set menu colours](https://github.com/bflycomputer/pond-pkgbuilds/blob/main/grub/0001-00_header-add-GRUB_COLOR_-variables.patch)

[0002: for config generator to recognize Arch initramfs file names](https://github.com/bflycomputer/pond-pkgbuilds/blob/main/grub/0002-10_linux-detect-archlinux-initramfs.patch)

[0003: adds /etc/default/grub.d/ as a config source](https://github.com/bflycomputer/pond-pkgbuilds/blob/main/grub/0003-support-dropins-for-default-configuration.patch)


It also bundles a [font](https://github.com/bflycomputer/pond-pkgbuilds/blob/main/grub/onest-21.pf2) for the grub theme.

*******************************************************************************
### If your shim launches any other components apart from your bootloader, please provide further details on what is launched.
Hint: The most common case here will be a firmware updater like fwupd.
*******************************************************************************
It only launches GRUB.

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
Skip this, if you're not using GRUB2 or systemd-boot.
*******************************************************************************
None.

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
Summarize in one or two sentences, how your secure bootchain works on higher level.
*******************************************************************************
The chain is only shim -> GRUB -> Linux

*******************************************************************************
### Does your shim load any loaders that support loading unsigned kernels (e.g. certain GRUB2 configurations)?
*******************************************************************************
No.

*******************************************************************************
### What kernel are you using? Which patches and configuration does it include to enforce Secure Boot?
*******************************************************************************
We use Linux 7.3.4 and 6.18.60. It includes the lockdown patches from Debian and locks down the kernel when booted in Secure Boot.

*******************************************************************************
### What contributions have you made to help us review the applications of other applicants?
The reviewing process is meant to be a peer-review effort and the best way to have your application reviewed faster is to help with reviewing others. We are in most cases volunteers working on this venue in our free time, rather than being employed and paid to review the applications during our business hours. 

A reasonable timeframe of waiting for a review can reach 2-3 months. Helping us is the best way to shorten this period. The more help we get, the faster and the smoother things will go.

For newcomers, the applications labeled as [*easy to review*](https://github.com/rhboot/shim-review/issues?q=is%3Aopen+is%3Aissue+label%3A%22easy+to+review%22) are recommended to start the contribution process.
*******************************************************************************
Intend to review other application post-submission.

*******************************************************************************
### Add any additional information you think we may need to validate this shim signing application.
*******************************************************************************
N/A
