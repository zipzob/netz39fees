class DirectDebitFees

  def initialize(fees, reference, remittance_information, requested_date, months_multiplier)
      init_direct_debit()
      @reference = reference
      @remittance_information = remittance_information
      @requested_date = Date.parse(requested_date)

      for fee in fees
        add_fee(fee, fee.total * months_multiplier.to_i)
      end
  end

  def init_direct_debit
    @direct_debit = SEPA::DirectDebit.new(
      # Name of the initiating party and creditor, in German: "Auftraggeber"
      # String, max. 70 char
      name: CONFIG[:sepa_name],

      # International Bank Account Number of the creditor
      # String, max. 34 chars
      iban: CONFIG[:sepa_iban],

      # Creditor Identifier, in German: Gläubiger-Identifikationsnummer
      # String, max. 35 chars
      creditor_identifier: CONFIG[:sepa_creditor_identifier]
    )
  end

  def add_fee(fee, amount)
    @direct_debit.add_transaction(
      # Name of the debtor, in German: "Zahlungspflichtiger"
      # String, max. 70 char
      name:fee.name_on_transaction,

      # International Bank Account Number of the debtor's account
      # String, max. 34 chars
      iban:fee.iban,

      # Amount in EUR
      # Number with two decimal digit
      amount:amount,

      # # OPTIONAL: Instruction Identification, will not be submitted to the debtor
      # # String, max. 35 char
      # instruction:               '12345',

      # OPTIONAL: End-To-End-Identification, will be submitted to the debtor
      # String, max. 35 char
      reference: @reference,

      # OPTIONAL: Unstructured remittance information, in German "Verwendungszweck"
      # String, max. 140 char
      remittance_information: @remittance_information,

      # Mandate identifikation, in German "Mandatsreferenz"
      # String, max. 35 char
      mandate_id: fee.mandate_id,

      # Mandate Date of signature, in German "Datum, zu dem das Mandat unterschrieben wurde"
      # Date
      mandate_date_of_signature: fee.mandate_date_of_signature,

      # Local instrument, in German "Lastschriftart"
      # One of these strings:
      #   'CORE' ("Basis-Lastschrift")
      #   'COR1' ("Basis-Lastschrift mit verkürzter Vorlagefrist")
      #   'B2B' ("Firmen-Lastschrift")
      local_instrument: 'CORE',

      # Sequence type
      # One of these strings:
      #   'FRST' ("Erst-Lastschrift")
      #   'RCUR' ("Folge-Lastschrift")
      #   'OOFF' ("Einmalige Lastschrift")
      #   'FNAL' ("Letztmalige Lastschrift")
      sequence_type: 'RCUR',

      # OPTIONAL: Requested collection date, in German "Fälligkeitsdatum der Lastschrift"
      # Date
      requested_date: @requested_date,

      # OPTIONAL: Enables or disables batch booking, in German "Sammelbuchung / Einzelbuchung"
      # True or False
      batch_booking: true,
    )
  end

  def to_xml
    @direct_debit.to_xml
  end
end
