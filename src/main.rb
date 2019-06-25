# frozen_string_literal: true

Dir.glob('/jars/**/*.jar').sort.each do |jar|
  require jar
end

java_import Java::ComGoogleProtobuf::MessageOrBuilder
java_import Java::ComGoogleCryptoTinkConfig::TinkConfig
java_import Java::ComGoogleCryptoTinkAead::AeadConfig
java_import Java::ComGoogleCryptoTink::KeysetHandle
java_import Java::ComGoogleCryptoTinkAead::AeadFactory
java_import Java::ComGoogleCryptoTinkAead::AesCtrKeyManager
java_import Java::ComGoogleCryptoTinkAead::AeadKeyTemplates

AeadConfig.register()

puts '-2-'
p AeadKeyTemplates::AES128_GCM
keyset_handle = KeysetHandle.generateNew AeadKeyTemplates::AES128_GCM
p keyset_handle

aead = AeadFactory.getPrimitive keyset_handle

plaintext = 'HelloWorld'
ciphertext = aead.encrypt(plaintext, '')
p ciphertext
