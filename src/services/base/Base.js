import {httpClient} from "./httpClient"

const baseUrl = "https://misaweb07api20230813092251.azurewebsites.net/api/v1";


class BaseRepository extends httpClient{

    //#region Constructor
    constructor(resource, baseDomain = baseUrl){
		super(baseDomain);
        this._controller = resource;
    }
    //#endregion

    //#region Methods

    //getter 

    /**
	 * lấy ra danh sách dữ liệu kèm theo thông tin phân trang
	 * @author: TNLAM (20-07-2022)
	 * @param {Number} pageIndex số trang bắt đầu từ 1
	 * @param {Number} pageSize số item/trang
	 * @param {String} filters từ khoá tìm kiếm
	 * @returns Promise chứa data để tiếp tục xử lý
	 */
	// getPaging(pageIndex, pageSize, filters) {
	// 	return this._repository.get(`${this.resource}?pageIndex=${pageIndex}&pageSize=${pageSize}&filter=${filters}`);
	// }

    /**
	 * lấy ra đối tượng dựa vào id
	 * @author: TNLAM (20-07-2022)
	 * @param {String} id id của employee
	 * @returns Promise chứa data để tiếp tục xử lý
	 */
	async getById(id, onSuccess, onFailure) {
		let config = {
			url : `${this._controller}/${id}`
		}
		return await this.getAsync(config, onSuccess, onFailure);
	}

    /**
	 * lấy ra tất cả dữ liệu
	 * @author: TNLAM (20-07-2022)
	 * @param
	 * @returns Promise chứa data để tiếp tục xử lý
	 */
	async getAll(onSuccess, onFailure) {
		let config = {
			url: [this._controller , 'all'].join('/')
		}
		return await this.getAsync(config, onSuccess, onFailure);
	}

    /**
	 * tạo mới một đối tượng dữ liệu
	 * @author: TNLAM (20-07-2022)
	 * @param {Object} dataObject cần tạo
	 * @returns Promise chứa data để tiếp tục xử lý
	 */
	create(dataObject, onSuccess, onFailure) {
		let config = {
			url: [this._controller].join('/'),
			data: dataObject
		}
		return this.postAsync(config, onSuccess, onFailure);
	}

    /**
	 * cập nhật mới một đối tượng dữ liệu
	 * @author: TNLAM (20-07-2022)
	 * @param {Object} dataObject cần sửa
	 * @returns Promise chứa data để tiếp tục xử lý
	 */
	update(dataObject, onSuccess, onFailure) {
		let config = {
			url: [this._controller].join('/'),
			data: dataObject
		}
		return this.putAsync(config, onSuccess, onFailure);
	}

    /**
	 * xóa một đối tượng dữ liệu
	 * @author: TNLAM (20-07-2022)
	 * @param {String} id dataObject cần xóa
	 * @returns Promise chứa data để tiếp tục xử lý
	 */
	delete(id, onSuccess, onFailure) {
		let config = {
			url: [this._controller, id].join('/'),
		}
		return this.deleteAsync(config, onSuccess, onFailure);
	}

    //#endregion
}

export {BaseRepository};


