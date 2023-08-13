/**
 * Object xử lý event global trên toàn bộ hệ thống
 */
import emitter from 'tiny-emitter/instance';

export default {
  $on: (...args) => emitter.on(...args),
  $once: (...args) => emitter.once(...args),
  $off: (...args) => emitter.off(...args),
  $emit: (...args) => emitter.emit(...args),
};

/**
 * Đối tượng liệt kê các global event đang có
 */
const GlobalEventName = {
  /**
   * Xử lý đóng tất form
   */

  /**
   * Phục vụ cho việc load lại dữ liệu
   */
  loadIssueComment: 'loadIssueComment',
  loadProjectSidebar: 'loadProjectSideBar',
  loadDetailIssue: 'loadDetailIssue',
  controlBlur: 'controlBlur',
};

export { GlobalEventName };
