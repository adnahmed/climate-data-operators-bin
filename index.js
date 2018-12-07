const EcCodesLib = require('eccodes-lib')

class CDOCustomBinary {
  constructor() {
    this.ecLib = new EcCodesLib()
  }

  async loadEcData(datas) {
    await this.ecLib.load(datas)
  }

  getEnv() {
    const env = this.ecLib.getEnv()
    env.LD_LIBRARY_PATH = `${env.LD_LIBRARY_PATH}:${__dirname}/lib`
    return env
  }

  getExecutable() {
    return `${__dirname}/bin/cdo`
  }

  async cleanup() {
    await this.ecLib.cleanup()
  }
}

module.exports = CDOCustomBinary
