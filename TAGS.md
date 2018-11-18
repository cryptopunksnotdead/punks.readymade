# Humanitarian eXchangle Language (HXL) Tags

[`#access`](#access)
[`#activity`](#activity)
[`#adm1`](#adm1)
[`#adm2`](#adm2)
[`#adm3`](#adm3)
[`#adm4`](#adm4)
[`#adm5`](#adm5)
[`#affected`](#affected)
[`#beneficiary`](#beneficiary)
[`#capacity`](#capacity)
[`#cause`](#cause)
[`#channel`](#channel)
[`#contact`](#contact)
[`#country`](#country)
[`#crisis`](#crisis)
[`#currency`](#currency)
[`#date`](#date)
[`#description`](#description)
[`#event`](#event)
[`#frequency`](#frequency)
[`#geo`](#geo)
[`#group`](#group)
[`#impact`](#impact)
[`#indicator`](#indicator)
[`#inneed`](#inneed)
[`#item`](#item)
[`#loc`](#loc)
[`#meta`](#meta)
[`#modality`](#modality)
[`#need`](#need)
[`#operations`](#operations)
[`#org`](#org)
[`#output`](#output)
[`#population`](#population)
[`#reached`](#reached)
[`#region`](#region)
[`#respondee`](#respondee)
[`#sector`](#sector)
[`#service`](#service)
[`#severity`](#severity)
[`#status`](#status)
[`#subsector`](#subsector)
[`#targeted`](#targeted)
[`#value`](#value)


## (1) Places

### `#adm1`

Top-level subnational administrative area (e.g. a governorate in Syria). _Since version 1.0_

Attributes: `+code +dest +name +origin`

### `#adm2`

Second-level subnational administrative area (e.g. a subdivision in Bangladesh). _Since version 1.0_

Attributes: `+code +dest +name +origin`

### `#adm3`

Third-level subnational administrative area (e.g. a subdistrict in Afghanistan). _Since version 1.0_

Attributes: `+code +dest +name +origin`

### `#adm4`

Fourth-level subnational administrative area (e.g. a barangay in the Philippines). _Since version 1.0_

Attributes: `+code +dest +name +origin`

### `#adm5`

Fifth-level subnational administrative area (e.g. a ward of a city). _Since version 1.0_

Attributes: `+code +dest +name +origin`

### `#country`

Country (often left implied in a dataset). Also sometimes known as admin level 0. _Since version 1.0_

Attributes: `+code +dest +name +origin`

### `#geo`

Geodetic geometry information (points, lines, shapes). Use for latitude and longitude, as well as bounds information. _Since version 1.0_

Attributes: `+bounds +coord +elevation +lat +lon`

### `#loc`

Any general location, such as a village, camp, or clinic. _Since version 1.0_

Attributes: `+code +dest +name +origin +type`

### `#region`

A broad, supra- or cross-national geographical region (e.g. Sahel, Horn of Africa, Central Asia, Caribbean). Not to be confused with "region" used as the name of a subnational area ([`#adm1`](#adm1)) in some countries. _Since version 1.0_

Attributes: `+code +dest +name +origin`

## (2) People and households

### `#affected`

Number of people or households affected by an emergency. Subset of [`#population`](#population); superset of [`#inneed`](#inneed). _Since version 1.0_

Every value must be a **number**.

Attributes: `+abducted +adolescents +adults +children +displaced +elderly +f +hh +i +idps +incamp +ind +infants +infected +injured +killed +m +noncamp +refugees`

### `#beneficiary`

General (non-numeric) information about a person or group meant to benefit from aid activities, e.g. "lactating women". _Since version 1.0_

Attributes: `+code +name +type`

### `#inneed`

Number of people or households in need of humanitarian assistance. Subset of [`#affected`](#affected); superset of [`#targeted`](#targeted). _Since version 1.0_

Every value must be a **number**.

Attributes: `+abducted +adolescents +adults +children +displaced +elderly +f +hh +i +idps +incamp +ind +infants +infected +injured +m +noncamp +refugees`

### `#population`

General population number for an area or location, regardless of their specific humanitarian needs. _Since version 1.0_

Every value must be a **number**.

Attributes: `+adolescents +adults +children +displaced +elderly +f +hh +i +idps +incamp +ind +infants +m +noncamp +refugees`

### `#reached`

Number of people or households reached with humanitarian assistance. Subset of [`#targeted`](#targeted). _Since version 1.0_

Every value must be a **number**.

Attributes: `+abducted +adolescents +adults +children +displaced +elderly +f +hh +i +idps +incamp +ind +infants +infected +injured +m +noncamp +refugees`

### `#respondee`

Descriptive information, such as name, identifier, or traits, for a single respondee (person, household, etc.) in survey-style data. _Since version 1.1_

### `#targeted`

Number of people or households targeted for humanitarian assistance. Subset of [`#inneed`](#inneed); superset of [`#reached`](#reached). _Since version 1.0_

Every value must be a **number**.

Attributes: `+abducted +adolescents +adults +children +displaced +elderly +f +hh +i +idps +incamp +ind +infants +infected +injured +m +noncamp +refugees`

## (3) Responses and other operations

### `#access`

Accessiblity and constraints on access to a market, distribution point, facility, etc. _Since version 1.1_

Attributes: `+type`

### `#activity`

A programme, project, or other activity. This hashtag applies to all levels; use the attributes +activity, +project, or +programme to distinguish different hierarchical levels. _Since version 1.0_

Attributes: `+activity +code +name +programme +project +type +url`

### `#capacity`

The response capacity of the entity being described (e.g. "25 beds"). _Since version 1.0_

Attributes: `+num +type`

### `#contact`

Contact information for the subject of a data record (e.g. an activity). _Since version 1.0_

Attributes: `+email +name +phone +type +url`

### `#frequency`

The frequency with which something occurs. _Since version 1.1_

Attributes: `+type`

### `#indicator`

A general hashtag for an indicator being tracked. See also [`#output`](#output), [`#capacity`](#capacity), [`#need`](#need), [`#impact`](#impact), [`#severity`](#severity), [`#affected`](#affected), [`#inneed`](#inneed), [`#targeted`](#targeted), and [`#reached`](#reached) for more-specific indicator-related hashtags. _Since version 1.0_

Attributes: `+code +name +num +text +type`

### `#item`

Physical things provided, stored, shipped, available, used, etc. _Since version 1.1_

Attributes: `+code +name +provided +type +used`

### `#need`

A(n) (unfulfilled) need for an affected person, household, group, or population. _Since version 1.1_

Attributes: `+code +name +type`

### `#operations`

Information that affects humanitarian operations, such as a restriction on movement or road closure. _Since version 1.0_

Attributes: `+type`

### `#org`

An organisation contributing to a humanitarian emergency response, e.g. a local government, community-based organisation, NGO, agency, donor, or law-enforcement or military unit. Use [`#group`](#group) for organisations that are not part of the emergency response (e.g. a paramilitary group). _Since version 1.0_

Attributes: `+code +funder +impl +name +prog +type +url`

### `#output`

An output indicator (e.g. "number of water-purification kits distributed"). A more-specific alternative to [`#indicator`](#indicator), especially for 3W-style activity reports. _Since version 1.0_

Attributes: `+code +name +num +type`

### `#sector`

A humanitarian cluster or sector. _Since version 1.0_

Attributes: `+cluster +code +name +type`

### `#service`

A service used or needed by an affected person, household, group, or population. _Since version 1.1_

Attributes: `+code +name +provided +type +url +used`

### `#subsector`

A humanitarian subsector. _Since version 1.0_

Attributes: `+code +name +type`

## (4) Cash and finance

### `#channel`

The detailed method of delivering aid (e.g. smartcard vs mobile transfer). More specific than [`#modality`](#modality). _Since version 1.1_

Attributes: `+code +name`

### `#currency`

Name or ISO 4217 currency code for all financial [`#value`](#value) cells in the row (e.g. "EUR"). Typically used together with [`#value`](#value) in financial or cash data. _Since version 1.1_

Attributes: `+code`

### `#modality`

The means by which an aid activity is accomplished. For cash transfers, values might include "cash", "vouchers", "in-kind", etc. May also be used for other types of modalities in other contexts. _Since version 1.1_

Attributes: `+code +name`

### `#value`

A monetary value, such as the price of goods in a market, a project budget, or the amount of cash transferred to beneficiaries. May be used together with [`#currency`](#currency) in financial or cash data. _Since version 1.1_

Every value must be a **number**.

## (5) Crises, incidents, and events

### `#cause`

The cause of an event, crisis, etc. _Since version 1.0_

Attributes: `+code +name +type`

### `#crisis`

A humanitarian emergency. _Since version 1.0_

Attributes: `+code +name +type`

### `#event`

An individual event or incident within a crisis/emergency, such as a (localised) flood, bridge collapse, or conflict. _Since version 1.0_

Attributes: `+code +name +type`

### `#group`

A non-humanitarian group (of any type) related to humanitarian crisis (e.g., a paramilitary group) Use [`#org`](#org) instead for a humanitarian organisation such as an NGO, contributing to the humanitarian response. _Since version 1.0_

Attributes: `+code +name +type`

### `#impact`

The impact of a crisis on a group or other entity. _Since version 1.0_

Attributes: `+code +name +type`

### `#severity`

Severity of the crisis or event. _Since version 1.0_

Attributes: `+code +name +type`

## (6) Metadata

### `#date`

Date related to the data in the record applies. Preferred format is ISO 8610 (e.g. "2015-06-01", "2015-Q1", etc.) _Since version 1.0_

Every value must be a **date**.

Attributes: `+approved +canceled +converted +end +occurred +reported +start`

### `#description`

Long description for a data record. _Since version 1.0_

Attributes: `+type`

### `#meta`

Metadata about a row. _Since version 1.0_

Attributes: `+id +source +url`

### `#status`

Project/activity status description (such as "planned", "active", "canceled", or "complete"). _Since version 1.0_

Attributes: `+code +name`

