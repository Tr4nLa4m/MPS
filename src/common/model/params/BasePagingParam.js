export class BasePagingParam {
    constructor() {
      /** @type {number} */
      this.PageIndex = 0;
  
      /** @type {number} */
      this.PageSize = 0;
  
      /** 
       * Trạng thái lọc bởi
       * @type {string | null} 
       */
      this.Sort = null;
  
      /** @type {string | null} */
      this.Where = null;
  
      /** 
       * Ngày bắt đầu để lọc
       * Default: 1/1/2000
       * @type {Date} 
       */
      this.StartDate = new Date(2000, 0, 1);
  
      /** 
       * Ngày kết thúc lọc
       * Default: 1/1/2050
       * @type {Date} 
       */
      this.EndDate = new Date(2050, 0, 1);
    }
  }